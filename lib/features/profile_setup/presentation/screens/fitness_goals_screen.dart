import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class FitnessGoalsScreen extends ConsumerStatefulWidget {
  const FitnessGoalsScreen({super.key});

  @override
  ConsumerState<FitnessGoalsScreen> createState() => _FitnessGoalsScreenState();
}

class _FitnessGoalsScreenState extends ConsumerState<FitnessGoalsScreen> {
  String? _selectedGoal;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _goals = [
    {'id': 'loseWeight', 'title': 'فقدان الوزن', 'subtitle': 'حرق الدهون والوصول لوزن مثالي', 'icon': Icons.remove_circle_outline, 'color': Colors.blue},
    {'id': 'buildMuscle', 'title': 'بناء العضلات', 'subtitle': 'زيادة الكتلة العضلية والقوة', 'icon': Icons.fitness_center, 'color': Colors.red},
    {'id': 'maintainWeight', 'title': 'الحفاظ على الوزن', 'subtitle': 'استقرار الوزن وتحسين التركيب الجسمي', 'icon': Icons.balance, 'color': Colors.green},
    {'id': 'improveFitness', 'title': 'تحسين اللياقة', 'subtitle': 'زيادة التحمل والطاقة اليومية', 'icon': Icons.directions_run, 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppConstants.largePadding),
                  children: [
                    Icon(Icons.flag, size: 60, color: theme.colorScheme.primary),
                    const SizedBox(height: 24),
                    Text('ما هو هدفك الرئيسي؟', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text('اختر هدفك لنخصص لك الخطة المثالية', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    ..._goals.map((goal) => _buildGoalCard(goal, theme)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: CustomButton(
                  text: 'التالي',
                  isLoading: _isLoading,
                  onPressed: _selectedGoal != null ? _handleContinue : null,
                  isFullWidth: true,
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal, ThemeData theme) {
    final isSelected = _selectedGoal == goal['id'];
    final color = goal['color'] as Color;

    return GestureDetector(
      onTap: () => setState(() => _selectedGoal = goal['id'] as String),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          border: Border.all(color: isSelected ? color : theme.colorScheme.outline, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(color: isSelected ? color : color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)), child: Icon(goal['icon'] as IconData, size: 24, color: isSelected ? Colors.white : color)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(goal['title'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(goal['subtitle'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ])),
            if (isSelected) Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  void _handleContinue() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ref.read(storageProvider).saveUserData({'goal': _selectedGoal});
      context.go('/profile-setup/diet');
    }
    setState(() => _isLoading = false);
  }
}
