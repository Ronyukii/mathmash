
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/adaptive_progress.dart';

class AdaptiveLearningService {
  static const String _storageKey = 'mathmash_adaptive_progress';

  static const int minimumLevel = 1;
  static const int maximumLevel = 3;

  static const int correctAnswersToIncrease = 3;
  static const int incorrectAnswersToDecrease = 2;

  static Future<Map<String, AdaptiveProgress>> getAllProgress() async {
    final preferences = await SharedPreferences.getInstance();
    final savedData = preferences.getString(_storageKey);

    if (savedData == null || savedData.isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(savedData) as Map<String, dynamic>;

      return decoded.map((key, value) {
        return MapEntry(
          key,
          AdaptiveProgress.fromJson(
            Map<String, dynamic>.from(value as Map),
          ),
        );
      });
    } catch (_) {
      return {};
    }
  }

  static Future<AdaptiveProgress> getProgress(String topicId) async {
    final allProgress = await getAllProgress();

    return allProgress[topicId] ??
        AdaptiveProgress(topicId: topicId);
  }

  static Future<int> getDifficultyLevel(String topicId) async {
    final progress = await getProgress(topicId);
    return progress.difficultyLevel;
  }

  static Future<AdaptiveProgress> recordAnswer({
    required String topicId,
    required bool isCorrect,
    required bool usedHint,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final allProgress = await getAllProgress();

    final previous = allProgress[topicId] ??
        AdaptiveProgress(topicId: topicId);

    int level = previous.difficultyLevel;
    int correctStreak = previous.correctStreak;
    int incorrectStreak = previous.incorrectStreak;

    if (isCorrect) {
      correctStreak++;
      incorrectStreak = 0;

      // Hinted answers count towards accuracy but do not
      // increase the difficulty streak.
      if (usedHint) {
        correctStreak = 0;
      } else if (correctStreak >= correctAnswersToIncrease) {
        level = (level + 1).clamp(
          minimumLevel,
          maximumLevel,
        ).toInt();
        correctStreak = 0;
      }
    } else {
      incorrectStreak++;
      correctStreak = 0;

      if (incorrectStreak >= incorrectAnswersToDecrease) {
        level = (level - 1).clamp(
          minimumLevel,
          maximumLevel,
        );
        incorrectStreak = 0;
      }
    }

    final updated = AdaptiveProgress(
      topicId: topicId,
      difficultyLevel: level,
      correctStreak: correctStreak,
      incorrectStreak: incorrectStreak,
      totalCorrect: previous.totalCorrect + (isCorrect ? 1 : 0),
      totalAnswered: previous.totalAnswered + 1,
    );

    allProgress[topicId] = updated;

    final encoded = jsonEncode(
      allProgress.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    );

    await preferences.setString(_storageKey, encoded);

    return updated;
  }

  static Future<void> resetTopic(String topicId) async {
    final preferences = await SharedPreferences.getInstance();
    final allProgress = await getAllProgress();

    allProgress.remove(topicId);

    final encoded = jsonEncode(
      allProgress.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    );

    await preferences.setString(_storageKey, encoded);
  }
}
