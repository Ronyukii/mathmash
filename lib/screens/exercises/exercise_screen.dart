import 'package:flutter/material.dart';
import '../../services/progress_service.dart';
import '../../services/adaptive_learning_service.dart';
import '../../theme/app_colors.dart';

class ExerciseQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String hint;
  final String explanation;
  final int difficulty;

  const ExerciseQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.hint,
    required this.explanation,
    this.difficulty = 1,
  });
}

class ExerciseScreen extends StatefulWidget {
  final String title;
  final String topic;
  final String exerciseId;
  final List<ExerciseQuestion> questions;
  final String topicId;

  const ExerciseScreen({
    super.key,
    required this.title,
    required this.topic,
    required this.exerciseId,
    required this.questions,
    required this.topicId,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int currentQuestion = 0;
  int score = 0;
  int attempts = 0;
  int? selectedAnswer;
  int currentDifficulty = 1;

  bool answered = false;
  bool showHint = false;
  bool completed = false;

  ExerciseQuestion get question =>
      widget.questions[currentQuestion];

  @override
  void initState() {
    super.initState();
    loadDifficulty();
  }

  Future<void> loadDifficulty() async {
    final level =
        await AdaptiveLearningService.getDifficultyLevel(
      widget.exerciseId,
    );

    if (!mounted) return;

    setState(() {
      currentDifficulty = level;
    });
  }
  

  Future<void> selectAnswer(int index) async {
    if (answered) return;

    final isCorrect = index == question.correctAnswer;

    // Update the immediate exercise feedback.
    setState(() {
      selectedAnswer = index;
      answered = true;

      if (isCorrect) {
        score++;
      }
    });

    try {
      // Record the answer and calculate the new difficulty.
      final updatedProgress =
          await AdaptiveLearningService.recordAnswer(
        topicId: widget.topicId,
        isCorrect: isCorrect,
        usedHint: showHint,
      );

      if (!mounted) return;

      // Refresh the displayed difficulty level.
      setState(() {
        currentDifficulty = updatedProgress.difficultyLevel;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to update learning progress.',
          ),
        ),
      );
    }
  }

  Future<void> nextQuestion() async {
    if (currentQuestion < widget.questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        answered = false;
        showHint = false;
      });
    } else {
      setState(() {
        completed = true;
      });

      try {
        await ProgressService.saveExerciseResult(
          exerciseId: widget.exerciseId,
          score: score,
          totalQuestions: widget.questions.length,
        );
      } catch (error) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to save your progress.'),
          ),
        );
      }
    }
  }

  void restartExercise() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      attempts = 0;
      selectedAnswer = null;
      answered = false;
      showHint = false;
      completed = false;
    });
  }

  Color optionColor(int index) {
    if (!answered) {
      return AppColors.white;
    }

    if (index == question.correctAnswer) {
      return AppColors.success.withOpacity(0.12);
    }

    if (index == selectedAnswer) {
      return AppColors.error.withOpacity(0.12);
    }

    return AppColors.white;
  }

  Color optionBorderColor(int index) {
    if (!answered) {
      return AppColors.secondary.withOpacity(0.3);
    }

    if (index == question.correctAnswer) {
      return AppColors.success;
    }

    if (index == selectedAnswer) {
      return AppColors.error;
    }

    return AppColors.secondary.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(widget.title),
        elevation: 0,
      ),
      body: completed ? buildResultScreen() : buildExercise(),
    );
  }

  Widget buildExercise() {
    final progress =
        (currentQuestion + 1) / widget.questions.length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.topic,
              style: TextStyle(
                color: AppColors.dark.withOpacity(0.65),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${currentQuestion + 1} '
                  'of ${widget.questions.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Score: $score',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Level $currentDifficulty',
                      style: TextStyle(
                        color: AppColors.dark.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),


            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 9,
                backgroundColor:
                    AppColors.secondary.withOpacity(0.25),
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Solve this question',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    question.question,
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            OutlinedButton.icon(
              onPressed: answered
                  ? null
                  : () {
                      setState(() {
                        showHint = !showHint;
                      });
                    },
              icon: const Icon(Icons.lightbulb_outline),
              label: Text(showHint ? 'Hide hint' : 'Show hint'),
            ),

            if (showHint && !answered) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.peach.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  question.hint,
                  style: TextStyle(color: AppColors.dark),
                ),
              ),
            ],

            const SizedBox(height: 18),

            Expanded(
              child: ListView.separated(
                itemCount: question.options.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final isCorrect =
                      index == question.correctAnswer;
                  final isSelected =
                      index == selectedAnswer;

                  return InkWell(
                    onTap: () => selectAnswer(index),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: optionColor(index),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: optionBorderColor(index),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.secondary
                                  .withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              question.options[index],
                              style: TextStyle(
                                color: AppColors.dark,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (answered && isCorrect)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          if (answered && isSelected && !isCorrect)
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (answered) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: selectedAnswer == question.correctAnswer
                      ? AppColors.success.withOpacity(0.12)
                      : AppColors.error.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedAnswer == question.correctAnswer
                          ? 'Correct! Well done.'
                          : 'Not quite. Try to understand why.',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(question.explanation),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    currentQuestion == widget.questions.length - 1
                        ? 'View Results'
                        : 'Next Question',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildResultScreen() {
    final percentage = widget.questions.isEmpty
        ? 0
        : (score / widget.questions.length * 100).round();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              percentage >= 60
                  ? Icons.emoji_events
                  : Icons.school,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Exercise Completed!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'You have completed ${widget.title}.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Accuracy'),
                  const SizedBox(height: 20),
                  Text(
                    '$score / ${widget.questions.length} correct answers',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Answers attempted: $attempts'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: restartExercise,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Try Again'),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () => Navigator.pop(context, {
                'score': score,
                'total': widget.questions.length,
                'percentage': percentage,
              }),
              child: const Text('Back to Learning'),
            ),
          ],
        ),
      ),
    );
  }
}
