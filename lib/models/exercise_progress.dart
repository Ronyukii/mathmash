
class ExerciseProgress {
  final String exerciseId;
  final int latestScore;
  final int bestScore;
  final int totalQuestions;
  final int attempts;
  final DateTime lastCompleted;

  const ExerciseProgress({
    required this.exerciseId,
    required this.latestScore,
    required this.bestScore,
    required this.totalQuestions,
    required this.attempts,
    required this.lastCompleted,
  });

  double get accuracy {
    if (totalQuestions == 0) return 0;
    return latestScore / totalQuestions;
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'latestScore': latestScore,
      'bestScore': bestScore,
      'totalQuestions': totalQuestions,
      'attempts': attempts,
      'lastCompleted': lastCompleted.toIso8601String(),
    };
  }

  factory ExerciseProgress.fromJson(Map<String, dynamic> json) {
    return ExerciseProgress(
      exerciseId: json['exerciseId'] as String,
      latestScore: json['latestScore'] as int,
      bestScore: json['bestScore'] as int,
      totalQuestions: json['totalQuestions'] as int,
      attempts: json['attempts'] as int,
      lastCompleted: DateTime.parse(
        json['lastCompleted'] as String,
      ),
    );
  }
}
