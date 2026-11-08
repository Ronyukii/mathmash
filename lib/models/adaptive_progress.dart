
class AdaptiveProgress {
  final String topicId;
  final int difficultyLevel;
  final int correctStreak;
  final int incorrectStreak;
  final int totalCorrect;
  final int totalAnswered;

  const AdaptiveProgress({
    required this.topicId,
    this.difficultyLevel = 1,
    this.correctStreak = 0,
    this.incorrectStreak = 0,
    this.totalCorrect = 0,
    this.totalAnswered = 0,
  });

  double get accuracy {
    if (totalAnswered == 0) return 0;
    return totalCorrect / totalAnswered;
  }

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'difficultyLevel': difficultyLevel,
      'correctStreak': correctStreak,
      'incorrectStreak': incorrectStreak,
      'totalCorrect': totalCorrect,
      'totalAnswered': totalAnswered,
    };
  }

  factory AdaptiveProgress.fromJson(Map<String, dynamic> json) {
    return AdaptiveProgress(
      topicId: json['topicId'] as String,
      difficultyLevel: json['difficultyLevel'] as int? ?? 1,
      correctStreak: json['correctStreak'] as int? ?? 0,
      incorrectStreak: json['incorrectStreak'] as int? ?? 0,
      totalCorrect: json['totalCorrect'] as int? ?? 0,
      totalAnswered: json['totalAnswered'] as int? ?? 0,
    );
  }
}
