import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDashboardScreen extends ConsumerStatefulWidget {
  final Widget? navigationShell;

  const MainDashboardScreen({super.key, this.navigationShell});

  @override
  ConsumerState<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends ConsumerState<MainDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(theme),
          _buildNutritionTab(theme),
          _buildWorkoutTab(theme),
          _buildPlansTab(theme),
          _buildProfileTab(theme),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu_outlined), selectedIcon: Icon(Icons.restaurant_menu), label: 'التغذية'),
          NavigationDestination(icon: Icon(Icons.fitness_center_outlined), selectedIcon: Icon(Icons.fitness_center), label: 'التمارين'),
          NavigationDestination(icon: Icon(Icons.card_membership_outlined), selectedIcon: Icon(Icons.card_membership), label: 'الخطط'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'الملف'),
        ],
      ),
    );
  }

  Widget _buildHomeTab(ThemeData theme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.surface,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('FitLife', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            centerTitle: true,
          ),
          actions: [
            IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeCard(theme),
                const SizedBox(height: 16),
                _buildQuickStats(theme),
                const SizedBox(height: 16),
                _buildTodayWorkout(theme),
                const SizedBox(height: 16),
                _buildQuickActions(theme),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('صباح الخير، بطل! 👋', style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('مستعد لليوم الجديد من الإنجازات؟', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: 0.9))),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.fitness_center, size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(ThemeData theme) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(theme, 'سعرات اليوم', '1850/2200', 'كcal', Icons.local_fire_department, Colors.orange)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard(theme, 'البروتين', '120/150', 'جم', Icons.fitness_center, Colors.red)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard(theme, 'الماء', '2.2/3.0', 'لتر', Icons.water_drop, Colors.blue)),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, String title, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(title, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildTodayWorkout(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.fitness_center, color: theme.colorScheme.primary, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تمرين اليوم', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('45 دقيقة • 4 تمارين', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('بدء'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme) {
    final actions = [
      _QuickAction(icon: Icons.restaurant_menu, label: 'خطة الغذاء', color: Colors.orange),
      _QuickAction(icon: Icons.fitness_center, label: 'خطة التمرين', color: Colors.blue),
      _QuickAction(icon: Icons.monitor_weight, label: 'قياسات الجسم', color: Colors.green),
      _QuickAction(icon: Icons.card_membership, label: 'اشتراكي', color: Colors.purple),
      _QuickAction(icon: Icons.local_shipping, label: 'توصيل الطعام', color: Colors.teal),
      _QuickAction(icon: Icons.analytics, label: 'التقارير', color: Colors.indigo),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('وصول سريع', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
          itemCount: actions.length,
          itemBuilder: (context, index) => _buildQuickActionCard(actions[index], theme),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(_QuickAction action, ThemeData theme) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: action.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
              child: Icon(action.icon, color: action.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(action.label, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionTab(ThemeData theme) {
    return Center(child: Text('التغذية', style: theme.textTheme.headlineMedium));
  }

  Widget _buildWorkoutTab(ThemeData theme) {
    return Center(child: Text('التمارين', style: theme.textTheme.headlineMedium));
  }

  Widget _buildPlansTab(ThemeData theme) {
    return Center(child: Text('الخطط', style: theme.textTheme.headlineMedium));
  }

  Widget _buildProfileTab(ThemeData theme) {
    return Center(child: Text('الملف الشخصي', style: theme.textTheme.headlineMedium));
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;

  _QuickAction({required this.icon, required this.label, required this.color});
}
