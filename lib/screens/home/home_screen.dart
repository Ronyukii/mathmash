import 'package:flutter/material.dart';
import '../learning/learning_map_screen.dart';
import '../../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    _DashboardTab(),
    LearningMapScreen(),
    _ChallengesTab(),
    _ProgressTab(),
    _ProfileTab(),
  ];

  static const List<String> _titles = [
    'Home',
    'Learning Map',
    'Challenges',
    'My Progress',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => _showInfo('Notifications will be available in a future update.'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        backgroundColor: AppColors.white,
        indicatorColor: AppColors.secondary.withOpacity(0.16),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_rounded),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            selectedIcon: Icon(Icons.bolt_rounded),
            label: 'Challenge',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights_rounded),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HELLO, LEARNER!',
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ready to mash\nsome maths?',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        height: 1.15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Small steps make big discoveries.',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.85),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const _BulbBadge(),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeading(
          title: 'Your learning snapshot',
          subtitle: 'A little progress goes a long way.',
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.menu_book_rounded,
                label: 'Lessons',
                value: '0',
                tint: Color(0xFFEAE8FF),
                iconColor: AppColors.secondary,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                icon: Icons.stars_rounded,
                label: 'Stars',
                value: '0',
                tint: Color(0xFFFFEBDD),
                iconColor: Color(0xFFCB814C),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                icon: Icons.local_fire_department_rounded,
                label: 'Day streak',
                value: '0',
                tint: Color(0xFFE4EEFF),
                iconColor: AppColors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const _SectionHeading(
          title: 'Pick up where you left off',
          subtitle: 'Your algebra journey starts here.',
        ),
        const SizedBox(height: 12),
        _ContinueCard(
          onTap: () => _selectTab(context, 1),
        ),
        const SizedBox(height: 26),
        const _SectionHeading(
          title: 'Explore MathMash',
          subtitle: 'Choose how you want to learn today.',
        ),
        const SizedBox(height: 12),
        _FeatureTile(
          icon: Icons.map_rounded,
          color: AppColors.secondary,
          title: 'Learning Map',
          description: 'Explore algebra topics at your own pace.',
          onTap: () => _selectTab(context, 1),
        ),
        const SizedBox(height: 10),
        _FeatureTile(
          icon: Icons.bolt_rounded,
          color: const Color(0xFFCB814C),
          title: 'Start a Challenge',
          description: 'Try a quick set of mathematics questions.',
          onTap: () => _selectTab(context, 2),
        ),
        const SizedBox(height: 10),
        _FeatureTile(
          icon: Icons.insights_rounded,
          color: AppColors.blue,
          title: 'View Progress',
          description: 'See your learning activity and achievements.',
          onTap: () => _selectTab(context, 3),
        ),
      ],
    );
  }

  static void _selectTab(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_HomeScreenState>();
    state?.setState(() => state._selectedIndex = index);
  }
}

class _LearningTab extends StatelessWidget {
  const _LearningTab();

  @override
  Widget build(BuildContext context) {
    final topics = [
      ('Getting to know algebra', 'Variables, constants and terms', Icons.lightbulb_outline),
      ('Algebraic expressions', 'Understand and simplify expressions', Icons.functions),
      ('Working with equations', 'Explore equality and simple equations', Icons.calculate_outlined),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _IntroPanel(
          title: 'Your learning map',
          description: 'Explore the building blocks of algebra. Work through topics in any order while MathMash takes shape.',
          icon: Icons.route_rounded,
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < topics.length; i++) ...[
          _TopicCard(
            number: i + 1,
            title: topics[i].$1,
            description: topics[i].$2,
            icon: topics[i].$3,
            onTap: () => _showComingSoon(context, 'Lesson content'),
          ),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 8),
        const Text(
          'Topic examples are placeholders and will be aligned with the Form 1 syllabus during content development.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }
}

class _ChallengesTab extends StatelessWidget {
  const _ChallengesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _IntroPanel(
          title: 'Ready for a challenge?',
          description: 'Practice what you know with short activities. Challenge questions will adapt as the learning design develops.',
          icon: Icons.bolt_rounded,
        ),
        const SizedBox(height: 18),
        _ChallengeCard(
          title: 'Quick practice',
          description: 'A short warm-up with basic algebra questions.',
          tag: '5 questions',
          icon: Icons.timer_outlined,
          onTap: () => _showComingSoon(context, 'Quick practice'),
        ),
        const SizedBox(height: 12),
        _ChallengeCard(
          title: 'Topic challenge',
          description: 'Focus on a topic you want to strengthen.',
          tag: 'Choose a topic',
          icon: Icons.track_changes_rounded,
          onTap: () => _showComingSoon(context, 'Topic challenge'),
        ),
        const SizedBox(height: 12),
        _ChallengeCard(
          title: 'Mixed challenge',
          description: 'Try a mix of algebra skills in one session.',
          tag: 'Mixed topics',
          icon: Icons.shuffle_rounded,
          onTap: () => _showComingSoon(context, 'Mixed challenge'),
        ),
      ],
    );
  }
}

class _ProgressTab extends StatelessWidget {
  const _ProgressTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _IntroPanel(
          title: 'Every step counts',
          description: 'Your completed lessons, practice results and topic mastery will appear here.',
          icon: Icons.insights_rounded,
        ),
        const SizedBox(height: 18),
        const _ProgressPlaceholder(
          title: 'Overall learning progress',
          value: '0%',
          progress: 0,
        ),
        const SizedBox(height: 12),
        const _ProgressPlaceholder(
          title: 'Algebra topic mastery',
          value: 'Not started',
          progress: 0,
        ),
        const SizedBox(height: 12),
        const _ProgressPlaceholder(
          title: 'Achievements',
          value: 'No badges yet',
          progress: 0,
        ),
        const SizedBox(height: 16),
        const Text(
          'Progress shown here is sample UI only. Local saving will be added when the first lesson and practice activities are implemented.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.peach,
                child: Icon(Icons.person_rounded, size: 40, color: AppColors.primary),
              ),
              SizedBox(height: 12),
              Text(
                'Guest Learner',
                style: TextStyle(color: AppColors.white, fontSize: 21, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5),
              Text(
                'Progress is currently for this device',
                style: TextStyle(color: AppColors.white.withOpacity(0.7), fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _ProfileOption(
          icon: Icons.person_add_alt_1_rounded,
          title: 'Create an account',
          subtitle: 'Sync your learning across devices in a future connected version.',
          onTap: () => _showComingSoon(context, 'Account creation and progress migration'),
        ),
        const SizedBox(height: 10),
        _ProfileOption(
          icon: Icons.settings_outlined,
          title: 'Settings',
          subtitle: 'App preferences and accessibility.',
          onTap: () => _showComingSoon(context, 'Settings'),
        ),
        const SizedBox(height: 10),
        _ProfileOption(
          icon: Icons.info_outline_rounded,
          title: 'About MathMash',
          subtitle: 'Learn Modern Mathematics with confidence.',
          onTap: () => showAboutDialog(
            context: context,
            applicationName: 'MathMash',
            applicationVersion: '0.1.0',
            applicationLegalese: 'An e-learning project for Form 1 students.',
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.dark)),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.tint,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color tint;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          CircleAvatar(radius: 19, backgroundColor: tint, child: Icon(icon, color: iconColor, size: 20)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.secondary.withOpacity(0.22)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.14), borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.functions_rounded, color: AppColors.secondary, size: 28),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start with algebra', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.dark)),
                  SizedBox(height: 4),
                  Text('Explore your first learning topic', style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 17, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.13), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark)),
        subtitle: Text(description, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}

class _IntroPanel extends StatelessWidget {
  const _IntroPanel({required this.title, required this.description, required this.icon});

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(description, style: TextStyle(color: AppColors.white.withOpacity(0.86), fontSize: 13, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: AppColors.peach, size: 42),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final int number;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withOpacity(0.14),
          child: Text('$number', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(description),
        trailing: Icon(icon, color: AppColors.secondary),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({
    required this.title,
    required this.description,
    required this.tag,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final String tag;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.peach.withOpacity(0.5),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('$description\n$tag'),
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}

class _ProgressPlaceholder extends StatelessWidget {
  const _ProgressPlaceholder({required this.title, required this.value, required this.progress});

  final String title;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
              Text(value, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: AppColors.secondary.withOpacity(0.13),
              valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: AppColors.secondary, size: 27),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _BulbBadge extends StatelessWidget {
  const _BulbBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.25),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.blue.withOpacity(0.55), width: 1.5),
      ),
      child: const Icon(Icons.lightbulb_rounded, color: AppColors.peach, size: 43),
    );
  }
}

void _showComingSoon(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$feature will be implemented in the next development phase.')),
  );
}
