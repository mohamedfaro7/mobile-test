import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final String workoutId;

  const WorkoutDetailScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final exercises = [
      {'name': 'ضغط بنش بار', 'sets': 4, 'reps': '8-12', 'weight': '60 كجم'},
      {'name': 'ضغط دمبلز مائل', 'sets': 3, 'reps': '10', 'weight': '20 كجم'},
      {'name': 'كابل فلاي', 'sets': 3, 'reps': '12', 'weight': '15 كجم'},
      {'name': 'ضغط ترايسبس بالكابل', 'sets': 3, 'reps': '12', 'weight': '25 كجم'},
      {'name': 'تراي سبيس فوق الرأس', 'sets': 3, 'reps': '10', 'weight': '15 كجم'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('تمرين اليوم $workoutId')),
      body: AnimatedBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
                borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('التمارين', '${exercises.length}', Icons.fitness_center),
                      _buildStatItem('المجموعات', '16', Icons.format_list_numbered),
                      _buildStatItem('الوقت', '55 د', Icons.timer),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'بدء التمرين',
                    onPressed: () {},
                    isFullWidth: true,
                    icon: Icons.play_arrow,
                    backgroundColor: Colors.white,
                    foregroundColor: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('التمارين', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            ...exercises.asMap().entries.map((entry) {
              final ex = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: Row(
                  children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.fitness_center, color: theme.colorScheme.primary)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(ex['name'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      Text('${ex['sets']} مجموعات × ${ex['reps']} تكرار • ${ex['weight']}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ])),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
