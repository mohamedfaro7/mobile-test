import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class ActivityLevelScreen extends ConsumerStatefulWidget {
  const ActivityLevelScreen({super.key});

  @override
  ConsumerState<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends ConsumerState<ActivityLevelScreen> {
  String? _selectedLevel;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _levels = [
    {'id': 'sedentary', 'title': 'خامل', 'subtitle': 'عمل مكتب، لا تمارين', 'icon': Icons.chair, 'color': Colors.grey},
    {'id': 'light', 'title': 'نشاط خفيف', 'subtitle': 'تمارين خفيفة 1-3 أيام/أسبوع', 'icon': Icons.directions_walk, 'color': Colors.blue},
    {'id': 'moderate', 'title': 'نشاط متوسط', 'subtitle': 'تمارين متوسطة 3-5 أيام/أسبوع', 'icon': Icons.fitness_center, 'color': Colors.green},
    {'id': 'active', 'title': 'نشاط عالي', 'subtitle': 'تمارين قوية 6-7 أيام/أسبوع', 'icon': Icons.sports, 'color': Colors.orange},
    {'id': 'veryActive', 'title': 'نشاط مكثف جداً', 'subtitle': 'تمارين قوية يومياً', 'icon': Icons.flash_on, 'color': Colors.red},
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
                    Icon(Icons.directions_run, size: 60, color: theme.colorScheme.primary),
                    const SizedBox(height: 24),
                    Text('مستوى النشاط', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text('اختر المستوى الذي يصف نمط حياتك', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    ..._levels.map((level) {
                      final isSelected = _selectedLevel == level['id'];
                      final color = level['color'] as Color;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedLevel = level['id'] as String),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(AppConstants.defaultPadding),
                          decoration: BoxDecoration(
                            color: isSelected ? color.withValues(alpha: 0.1) : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                            border: Border.all(color: isSelected ? color : theme.colorScheme.outline, width: isSelected ? 2 : 1),
                          ),
                          child: Row(
                            children: [
                              Container(width: 50, height: 50, decoration: BoxDecoration(color: isSelected ? color : color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)), child: Icon(level['icon'] as IconData, size: 24, color: isSelected ? Colors.white : color)),
                              const SizedBox(width: 16),
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(level['title'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(level['subtitle'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                              ])),
                              if (isSelected) Icon(Icons.check_circle, color: color),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                child: CustomButton(
                  text: 'إكمال الإعداد',
                  isLoading: _isLoading,
                  onPressed: _selectedLevel != null ? _handleComplete : null,
                  isFullWidth: true,
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleComplete() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ref.read(storageProvider).saveUserData({'activityLevel': _selectedLevel});
      context.go('/dashboard');
    }
    setState(() => _isLoading = false);
  }
}
