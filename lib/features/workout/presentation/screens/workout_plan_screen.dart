import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class WorkoutPlanScreen extends ConsumerWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('خطة التمارين'),
        actions: [IconButton(icon: const Icon(Icons.fitness_center), onPressed: () {})],
      ),
      body: AnimatedBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)]),
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(width: 60, height: 60, decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)), child: Icon(Icons.fitness_center, color: theme.colorScheme.primary)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('برنامج القوة الأساسية', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text('12 أسبوع • 4 أيام/أسبوع • 60 دقيقة', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildDayCard(context, theme, 1, 'الصدر والترايسبس', '5 تمارين • 55 دقيقة', false),
            _buildDayCard(context, theme, 2, 'الظهر والبايسبس', '5 تمارين • 55 دقيقة', false),
            _buildDayCard(context, theme, 3, 'راحة نشطة', 'مشي خفيف 30 دقيقة', true),
            _buildDayCard(context, theme, 4, 'الأرجل والكتف', '5 تمارين • 65 دقيقة', false),
            _buildDayCard(context, theme, 5, 'راحة', 'راحة تامة', true),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, ThemeData theme, int day, String name, String details, bool isRest) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
        leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: isRest ? Colors.grey.withValues(alpha: 0.15) : theme.colorScheme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)), child: Icon(isRest ? Icons.spa : Icons.fitness_center, color: isRest ? Colors.grey : theme.colorScheme.primary)),
        title: Text('اليوم $day: $name', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(details, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        trailing: isRest ? null : CustomButton(text: 'ابدأ', onPressed: () => context.push('/workout/$day'), isFullWidth: false),
      ),
    );
  }
}
