import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: [IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {})],
      ),
      body: AnimatedBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
                  borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      child: const Text('أ', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 16),
                    const Text('أحمد محمد', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('user@example.com', style: TextStyle(color: Colors.white.withValues(alpha: 0.8))),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(theme, 'المعلومات الشخصية', [
                _buildInfoRow(theme, 'الاسم', 'أحمد محمد', Icons.person_outline),
                _buildInfoRow(theme, 'البريد', 'user@example.com', Icons.email_outlined),
                _buildInfoRow(theme, 'الهاتف', '+966 50 123 4567', Icons.phone_outlined),
              ]),
              const SizedBox(height: 16),
              _buildSection(theme, 'قياسات الجسم', [
                _buildInfoRow(theme, 'الطول', '180 سم', Icons.height),
                _buildInfoRow(theme, 'الوزن', '82.5 كجم', Icons.monitor_weight),
                _buildInfoRow(theme, 'العمر', '28 سنة', Icons.cake),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(ThemeData theme, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: theme.colorScheme.primary, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          ])),
        ],
      ),
    );
  }
}
