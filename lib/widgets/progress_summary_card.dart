
import 'package:flutter/material.dart';

import '../services/progress_service.dart';
import '../theme/app_colors.dart';

class ProgressSummaryCard extends StatelessWidget {
  const ProgressSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadSummary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final data = snapshot.data ??
            {
              'completed': 0,
              'accuracy': 0.0,
            };

        final completed = data['completed'] as int;
        final accuracy = data['accuracy'] as double;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Learning Progress',
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: _ProgressItem(
                      label: 'Exercises',
                      value: '$completed',
                      icon: Icons.assignment_turned_in,
                    ),
                  ),
                  Expanded(
                    child: _ProgressItem(
                      label: 'Average accuracy',
                      value: '${accuracy.toStringAsFixed(0)}%',
                      icon: Icons.track_changes,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: accuracy / 100,
                  minHeight: 9,
                  backgroundColor:
                      AppColors.secondary.withOpacity(0.25),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _loadSummary() async {
    final completed =
        await ProgressService.getCompletedExerciseCount();

    final average =
        await ProgressService.getAverageAccuracy();

    return {
      'completed': completed,
      'accuracy': average * 100,
    };
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ProgressItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 25,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.dark.withOpacity(0.65),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
