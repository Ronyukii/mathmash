
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class LearningMapScreen extends StatelessWidget {
  const LearningMapScreen({super.key});

  static const List<_LearningTopic> topics = [
    _LearningTopic(
      title: 'Meet Algebra',
      subtitle: 'Discover variables and constants',
      difficulty: 'Beginner',
      icon: Icons.lightbulb_outline_rounded,
      color: Color(0xFF7D75FF),
      lessons: 3,
    ),
    _LearningTopic(
      title: 'Algebraic Terms',
      subtitle: 'Understand coefficients and terms',
      difficulty: 'Beginner',
      icon: Icons.functions_rounded,
      color: Color(0xFF568FD4),
      lessons: 3,
    ),
    _LearningTopic(
      title: 'Algebraic Expressions',
      subtitle: 'Write and evaluate expressions',
      difficulty: 'Intermediate',
      icon: Icons.calculate_outlined,
      color: Color(0xFFCB814C),
      lessons: 4,
    ),
    _LearningTopic(
      title: 'Simplifying Expressions',
      subtitle: 'Combine like terms',
      difficulty: 'Intermediate',
      icon: Icons.auto_fix_high_rounded,
      color: Color(0xFF55B88A),
      lessons: 4,
    ),
    _LearningTopic(
      title: 'Linear Equations',
      subtitle: 'Understand equality and equations',
      difficulty: 'Advanced',
      icon: Icons.balance_rounded,
      color: Color(0xFF9B70C9),
      lessons: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        _buildHeader(),
        const SizedBox(height: 22),
        _buildProgressCard(),
        const SizedBox(height: 26),
        const Text(
          'YOUR ALGEBRA JOURNEY',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Learn one step at a time.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(
          topics.length,
          (index) => _buildTopic(
            context,
            topics[index],
            index,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEARNING MAP',
                  style: TextStyle(
                    color: AppColors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your journey into algebra starts here!',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 21,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Icon(
            Icons.route_rounded,
            color: AppColors.peach,
            size: 52,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall progress',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
              Text(
                '0 / 5 topics',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 13),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: LinearProgressIndicator(
              value: 0,
              minHeight: 9,
              backgroundColor: Color(0xFFEAE8FF),
              valueColor: AlwaysStoppedAnimation(
                AppColors.secondary,
              ),
            ),
          ),
          SizedBox(height: 9),
          Text(
            'Start learning to build your progress!',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopic(
    BuildContext context,
    _LearningTopic topic,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showTopicDetails(context, topic),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: topic.color.withOpacity(0.25),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: topic.color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  topic.icon,
                  color: topic.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOPIC ${index + 1}',
                      style: TextStyle(
                        fontSize: 10,
                        color: topic.color,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${topic.difficulty} • ${topic.lessons} lessons',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: topic.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTopicDetails(
    BuildContext context,
    _LearningTopic topic,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Icon(
                topic.icon,
                color: topic.color,
                size: 45,
              ),
              const SizedBox(height: 15),
              Text(
                topic.title,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                topic.subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '${topic.lessons} planned lessons • ${topic.difficulty}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Lesson content will be added in the next phase.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Explore Topic'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LearningTopic {
  const _LearningTopic({
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.icon,
    required this.color,
    required this.lessons,
  });

  final String title;
  final String subtitle;
  final String difficulty;
  final IconData icon;
  final Color color;
  final int lessons;
}
