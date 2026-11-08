
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/exercise_progress.dart';

class ProgressService {
  static const String _storageKey = 'mathmash_exercise_progress';

  // Load all saved exercise progress.
  static Future<Map<String, ExerciseProgress>> getAllProgress() async {
    final preferences = await SharedPreferences.getInstance();

    final savedData = preferences.getString(_storageKey);

    if (savedData == null || savedData.isEmpty) {
      return {};
    }

    try {
      final Map<String, dynamic> decoded =
          jsonDecode(savedData) as Map<String, dynamic>;

      return decoded.map((key, value) {
        return MapEntry(
          key,
          ExerciseProgress.fromJson(
            Map<String, dynamic>.from(value as Map),
          ),
        );
      });
    } catch (error) {
      // Return an empty result if stored data cannot be decoded.
      return {};
    }
  }

  // Get progress for one exercise.
  static Future<ExerciseProgress?> getExerciseProgress(
    String exerciseId,
  ) async {
    final allProgress = await getAllProgress();
    return allProgress[exerciseId];
  }

  // Save a completed exercise attempt.
  static Future<void> saveExerciseResult({
    required String exerciseId,
    required int score,
    required int totalQuestions,
  }) async {
    if (totalQuestions <= 0 || score < 0 || score > totalQuestions) {
      throw ArgumentError('Invalid exercise score.');
    }

    final preferences = await SharedPreferences.getInstance();
    final allProgress = await getAllProgress();

    final previous = allProgress[exerciseId];

    final bestScore = previous == null
        ? score
        : (score > previous.bestScore ? score : previous.bestScore);

    final updatedProgress = ExerciseProgress(
      exerciseId: exerciseId,
      latestScore: score,
      bestScore: bestScore,
      totalQuestions: totalQuestions,
      attempts: (previous?.attempts ?? 0) + 1,
      lastCompleted: DateTime.now(),
    );

    allProgress[exerciseId] = updatedProgress;

    final encoded = jsonEncode(
      allProgress.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    );

    await preferences.setString(_storageKey, encoded);
  }

  // Calculate the number of completed exercises.
  static Future<int> getCompletedExerciseCount() async {
    final progress = await getAllProgress();
    return progress.length;
  }

  // Calculate average latest accuracy across completed exercises.
  static Future<double> getAverageAccuracy() async {
    final progress = await getAllProgress();

    if (progress.isEmpty) return 0;

    final totalAccuracy = progress.values.fold<double>(
      0,
      (total, item) => total + item.accuracy,
    );

    return totalAccuracy / progress.length;
  }

  // Remove all saved exercise progress.
  static Future<void> clearProgress() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_storageKey);
  }
}
