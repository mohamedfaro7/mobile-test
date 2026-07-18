import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: AnimatedBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          children: [
            _buildSectionHeader(theme, 'الحساب', Icons.person),
            _buildSettingsCard(theme, [
              _buildSettingsTile(theme, icon: Icons.person_outline, title: 'الملف الشخصي', subtitle: 'تعديل معلوماتك', onTap: () => context.push('/profile')),
              _buildSettingsTile(theme, icon: Icons.lock_outline, title: 'تغيير كلمة المرور', subtitle: 'تحديث كلمة المرور', onTap: () => context.push('/change-password')),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(theme, 'المظهر', Icons.palette),
            _buildSettingsCard(theme, [
              _buildSettingsTile(theme, icon: Icons.dark_mode_outlined, title: 'الوضع الداكن', subtitle: 'تبديل المظهر', onTap: () => context.push('/theme')),
              _buildSettingsTile(theme, icon: Icons.language_outlined, title: 'اللغة', subtitle: 'اختر لغة التطبيق', onTap: () => context.push('/language')),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(theme, 'الإشعارات', Icons.notifications),
            _buildSettingsCard(theme, [
              _buildSettingsTile(theme, icon: Icons.notifications_outlined, title: 'إعدادات الإشعارات', subtitle: 'إدارة الإشعارات', onTap: () {}),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(theme, 'التطبيق', Icons.phone_android),
            _buildSettingsCard(theme, [
              _buildSettingsTile(theme, icon: Icons.help_outline, title: 'مركز المساعدة', subtitle: 'الأسئلة الشائعة', onTap: () => context.push('/help')),
              _buildSettingsTile(theme, icon: Icons.info_outline, title: 'حول التطبيق', subtitle: 'الإصدار والمعلومات', onTap: () => context.push('/about')),
            ]),
            const SizedBox(height: 24),
            Text('الإصدار ${AppConstants.appVersion} (${AppConstants.buildNumber})', textAlign: TextAlign.center, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(ThemeData theme, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile(ThemeData theme, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return ListTile(
      leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: theme.colorScheme.primary, size: 20)),
      title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      trailing: Icon(Icons.chevron_left, color: theme.colorScheme.onSurfaceVariant),
      onTap: onTap,
    );
  }
}
