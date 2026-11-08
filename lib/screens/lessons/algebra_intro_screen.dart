
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AlgebraIntroScreen extends StatefulWidget {
  const AlgebraIntroScreen({super.key});

  @override
  State<AlgebraIntroScreen> createState() =>
      _AlgebraIntroScreenState();
}

class _AlgebraIntroScreenState
    extends State<AlgebraIntroScreen> {
  int section = 0;
  int questionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool answered = false;
  bool completed = false;

  final questions = const [
    _Question(
      question: 'What is a variable?',
      options: [
        'A number that never changes',
        'A symbol representing a value',
        'An arithmetic operation',
        'A mathematical answer',
      ],
      answer: 1,
      explanation:
          'A variable is a symbol, usually a letter, that represents an unknown or changing value.',
    ),
    _Question(
      question: 'Which of these is a constant?',
      options: ['x', 'y', '8', 'a'],
      answer: 2,
      explanation:
          'A constant is a fixed value. The number 8 does not change.',
    ),
    _Question(
      question: 'In 5x, what is the coefficient?',
      options: ['x', '5', '5x', '0'],
      answer: 1,
      explanation:
          'The coefficient is the number multiplying a variable. Here, 5 multiplies x.',
    ),
    _Question(
      question: 'Which expression represents 3 more than x?',
      options: ['3x', 'x - 3', 'x + 3', '3 - x'],
      answer: 2,
      explanation:
          'More than means addition, so 3 more than x is x + 3.',
    ),
    _Question(
      question: 'If x = 4, what is the value of 2x + 3?',
      options: ['9', '10', '11', '14'],
      answer: 2,
      explanation:
          'Substitute 4 for x: 2(4) + 3 = 8 + 3 = 11.',
    ),
  ];

  void nextSection() {
    setState(() {
      if (section < 3) {
        section++;
      } else {
        section = 4;
      }
    });
  }

  void chooseAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == questions[questionIndex].answer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        selectedAnswer = null;
        answered = false;
      } else {
        completed = true;
      }
    });
  }

  void restartLesson() {
    setState(() {
      section = 0;
      questionIndex = 0;
      score = 0;
      selectedAnswer = null;
      answered = false;
      completed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Algebra Foundations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildProgress(),
          Expanded(
            child: completed
                ? _buildCompletion()
                : section == 4
                    ? _buildQuiz()
                    : _buildLessonContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    final progress = completed
        ? 1.0
        : section / 4;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                completed
                    ? 'Lesson completed'
                    : section == 4
                        ? 'Knowledge check'
                        : 'Learning section ${section + 1} of 4',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.secondary
                  .withOpacity(0.15),
              valueColor:
                  const AlwaysStoppedAnimation(
                AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (section == 0) ...[
            _heading('What is Algebra?'),
            _paragraph(
              'Algebra is a branch of mathematics that uses letters and symbols to represent numbers and relationships.',
            ),
            _exampleCard(
              title: 'Think about it!',
              content: 'You have 3 apples. Your friend gives you some more. How can we represent the total?',
              formula: '3 + x',
            ),
            _paragraph(
              'Instead of knowing every number immediately, algebra allows us to work with unknown values.',
            ),
          ],

          if (section == 1) ...[
            _heading('Variables and Constants'),
            _paragraph(
              'A variable is a letter or symbol that represents a value. A constant is a fixed number.',
            ),
            _conceptCard(
              title: 'Variable',
              symbol: 'x',
              description:
                  'Represents an unknown or changing value.',
              color: AppColors.secondary,
            ),
            const SizedBox(height: 14),
            _conceptCard(
              title: 'Constant',
              symbol: '5',
              description:
                  'A fixed numerical value.',
              color: AppColors.blue,
            ),
            _exampleCard(
              title: 'Example',
              content:
                  'In the expression below, x is the variable and 5 is the constant.',
              formula: 'x + 5',
            ),
          ],

          if (section == 2) ...[
            _heading('Understanding Coefficients'),
            _paragraph(
              'A coefficient is the number multiplied by a variable.',
            ),
            _exampleCard(
              title: 'Look at this expression',
              content:
                  'The number 4 multiplies the variable x.',
              formula: '4x',
            ),
            _conceptCard(
              title: 'Coefficient',
              symbol: '4',
              description:
                  'The number multiplying the variable.',
              color: AppColors.peach,
            ),
            _paragraph(
              'Remember: when a number and a variable appear together, multiplication is implied.',
            ),
          ],

          if (section == 3) ...[
            _heading('Worked Example'),
            _paragraph(
              'Let us identify the parts of this algebraic expression.',
            ),
            _exampleCard(
              title: 'Expression',
              content:
                  'Consider the expression 3x + 7.',
              formula: '3x + 7',
            ),
            _conceptCard(
              title: '3',
              symbol: '3',
              description: 'Coefficient of x.',
              color: AppColors.secondary,
            ),
            const SizedBox(height: 10),
            _conceptCard(
              title: 'x',
              symbol: 'x',
              description: 'Variable.',
              color: AppColors.blue,
            ),
            const SizedBox(height: 10),
            _conceptCard(
              title: '7',
              symbol: '7',
              description: 'Constant.',
              color: AppColors.peach,
            ),
            const SizedBox(height: 14),
            _exampleCard(
              title: 'Try substituting x = 2',
              content:
                  'Replace x with 2, then calculate.',
              formula: '3(2) + 7 = 13',
            ),
          ],

          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: nextSection,
              child: Text(
                section == 3
                    ? 'Start Knowledge Check'
                    : 'Continue Learning',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuiz() {
    final question = questions[questionIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUESTION ${questionIndex + 1} OF ${questions.length}',
            style: const TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 25),

          ...List.generate(
            question.options.length,
            (index) {
              final isCorrect =
                  index == question.answer;

              final isSelected =
                  selectedAnswer == index;

              Color background =
                  AppColors.white;

              Color border =
                  const Color(0xFFE5E1F5);

              if (answered && isCorrect) {
                background =
                    AppColors.success.withOpacity(0.15);
                border = AppColors.success;
              } else if (answered && isSelected) {
                background =
                    AppColors.error.withOpacity(0.12);
                border = AppColors.error;
              }

              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => chooseAnswer(index),
                  borderRadius:
                      BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius:
                          BorderRadius.circular(16),
                      border: Border.all(
                        color: border,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.dark,
                            ),
                          ),
                        ),
                        if (answered && isCorrect)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                          ),
                        if (answered &&
                            isSelected &&
                            !isCorrect)
                          const Icon(
                            Icons.cancel,
                            color: AppColors.error,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          if (answered) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: AppColors.secondary
                    .withOpacity(0.10),
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedAnswer ==
                            question.answer
                        ? 'Excellent work!'
                        : 'Not quite. Keep learning!',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(question.explanation),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: nextQuestion,
                child: Text(
                  questionIndex ==
                          questions.length - 1
                      ? 'See My Results'
                      : 'Next Question',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCompletion() {
    final percentage =
        (score / questions.length * 100).round();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.peach,
              size: 95,
            ),
            const SizedBox(height: 20),
            const Text(
              'Lesson Completed!',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You answered $score out of ${questions.length} questions correctly.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Text(
              '$percentage%',
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 55,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              percentage >= 80
                  ? 'Great understanding!'
                  : percentage >= 60
                      ? 'Good effort! Keep practising.'
                      : 'Review the lesson and try again.',
              style: const TextStyle(
                color: AppColors.dark,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, score),
              child: const Text('Finish Lesson'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: restartLesson,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heading(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: AppColors.dark,
        ),
      ),
    );
  }

  Widget _exampleCard({
    required String title,
    required String content,
    required String formula,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.peach,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: AppColors.white,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Text(
              formula,
              style: const TextStyle(
                color: AppColors.peach,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _conceptCard({
    required String title,
    required String symbol,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Text(
              symbol,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Question {
  const _Question({
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });

  final String question;
  final List<String> options;
  final int answer;
  final String explanation;
}
