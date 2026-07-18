import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.colorScheme.surface, theme.colorScheme.surfaceContainerHighest],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.orange.withValues(alpha: 0.2), Colors.orange.withValues(alpha: 0.05)]),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.construction, size: 60, color: Colors.orange),
                ),
                const SizedBox(height: 32),
                Text('الصيانة المجدولة', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Text('نحن نقوم بصيانة مجدولة لتحسين تجربتك.\nالرجاء المحاولة مرة أخرى بعد قليل.', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(AppConstants.largePadding),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.schedule, color: Colors.orange, size: 24),
                          const SizedBox(width: 12),
                          Expanded(child: Text('وقت الصيانة المتوقع: 30 دقيقة', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.orange))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('نعتذر عن أي إزعاج. فريقنا يعمل على تحسين الأداء!', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.orange.shade700)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(onPressed: () => context.go('/'), icon: const Icon(Icons.refresh), label: const Text('إعادة المحاولة')),
                    const SizedBox(width: 16),
                    FilledButton.icon(onPressed: () => context.push('/help'), icon: const Icon(Icons.help_outline), label: const Text('الدعم الفني')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
