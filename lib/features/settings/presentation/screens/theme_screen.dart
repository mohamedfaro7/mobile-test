import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class ThemeScreen extends ConsumerStatefulWidget {
  const ThemeScreen({super.key});

  @override
  ConsumerState<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemeScreen> {
  ThemeMode _selectedThemeMode = ThemeMode.system;

  final List<ThemeOption> _themeOptions = [
    ThemeOption(
      mode: ThemeMode.light,
      name: 'فاتح',
      description: 'وضع فاتح دائماً',
      icon: Icons.light_mode,
      color: Colors.amber,
    ),
    ThemeOption(
      mode: ThemeMode.dark,
      name: 'داكن',
      description: 'وضع داكن دائماً',
      icon: Icons.dark_mode,
      color: Colors.indigo,
    ),
    ThemeOption(
      mode: ThemeMode.system,
      name: 'النظام',
      description: 'يتابع إعدادات النظام',
      icon: Icons.settings_system_daydream,
      color: Colors.teal,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedThemeMode = ref.read(themeModeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المظهر'),
        elevation: 0,
      ),
      body: AnimatedBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          children: [
            _buildHeader(theme),
            const SizedBox(height: 24),
            _buildCurrentThemePreview(theme),
            const SizedBox(height: 24),
            ..._themeOptions.map((option) => _buildThemeOptionCard(option, theme)
                .animate()
                .fadeIn(delay: (_themeOptions.indexOf(option) * 100).ms)
                .slideX(begin: -0.2)),
            const SizedBox(height: 24),
            _buildAccentColorSelector(theme),
            const SizedBox(height: 24),
            _buildFontSizeSelector(theme),
            const SizedBox(height: 24),
            _buildAnimationsToggle(theme),
            const SizedBox(height: 24),
            _buildInfoCard(theme),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.palette, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تخصيص المظهر', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('اختر السمة والألوان التي تفضلها', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentThemePreview(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('المظهر الحالي', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Row(
            children: _themeOptions.map((option) {
              final isSelected = _selectedThemeMode == option.mode;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _changeTheme(option.mode),
                  child: AnimatedContainer(
                    duration: 300.ms,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary])
                          : null,
                      color: isSelected ? null : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                      border: Border.all(
                        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(option.icon, size: 32, color: isSelected ? Colors.white : theme.colorScheme.onSurfaceVariant),
                        const SizedBox(height: 8),
                        Text(option.name, style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                        )),
                        const SizedBox(height: 4),
                        Text(option.description, style: theme.textTheme.labelSmall?.copyWith(
                          color: isSelected ? Colors.white.withValues(alpha: 0.8) : theme.colorScheme.onSurfaceVariant,
                        ), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              );
              }).toList(),
            ),
          ],
        ),
      );
  }

  Widget _buildThemeOptionCard(ThemeOption option, ThemeData theme) {
    final isSelected = _selectedThemeMode == option.mode;

    return GestureDetector(
      onTap: () => _changeTheme(option.mode),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [option.color.withValues(alpha: 0.15), option.color.withValues(alpha: 0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          border: Border.all(color: isSelected ? option.color : theme.colorScheme.outline, width: isSelected ? 2 : 1),
          boxShadow: isSelected ? [BoxShadow(color: option.color.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? option.color : option.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(option.icon, size: 24, color: isSelected ? Colors.white : option.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: isSelected ? option.color : theme.colorScheme.onSurface)),
                  const SizedBox(height: 2),
                  Text(option.description, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            AnimatedContainer(
              duration: 300.ms,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? option.color : Colors.transparent,
                border: Border.all(color: isSelected ? option.color : theme.colorScheme.outline, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccentColorSelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('لون التمييز', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اختر لون التمييز للأزرار والروابط', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _accentColors.map((color) => _buildColorOption(color, theme)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorOption(Color color, ThemeData theme) {
    final isSelected = false; // TODO: Implement accent color selection

    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: 300.ms,
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 3),
          boxShadow: isSelected ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(0, 4))] : null,
        ),
        child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 24) : null,
      ),
    );
  }

  Widget _buildFontSizeSelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('حجم الخط', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ضبط حجم النص في التطبيق', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildFontSizeButton('صغير', 0.85, theme),
                  const SizedBox(width: 12),
                  _buildFontSizeButton('عادي', 1.0, theme),
                  const SizedBox(width: 12),
                  _buildFontSizeButton('كبير', 1.15, theme),
                  const SizedBox(width: 12),
                  _buildFontSizeButton('كبير جداً', 1.3, theme),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFontSizeButton(String label, double scale, ThemeData theme) {
    final isSelected = false; // TODO: Implement font size selection

    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline, width: isSelected ? 2 : 1),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationsToggle(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الحركات والتأثيرات', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _buildToggleItem(
            theme,
            'حركات الانتقال',
            'تأثيرات الانتقال بين الشاشات',
            Icons.animation,
            true,
            (value) {},
          ),
          _buildToggleItem(
            theme,
            'حركات القوائم',
            'ظهور العناصر بتأثير تدريجي',
            Icons.list_alt,
            true,
            (value) {},
          ),
          _buildToggleItem(
            theme,
            'حركات الأزرار',
            'تأثير الضغط والتكبير',
            Icons.touch_app,
            true,
            (value) {},
          ),
          _buildToggleItem(
            theme,
            'تقليل الحركة',
            'للتوفير في البطارية والأداء',
            Icons.battery_saver,
            false,
            (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(ThemeData theme, String title, String subtitle, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      secondary: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: theme.colorScheme.primary, size: 20),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: theme.colorScheme.primary,
    );
  }

  Widget _buildInfoCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text('نصيحة', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Text('• الوضع الداكن يوفر البطارية في الشاشات OLED', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 4),
          Text('• وضع النظام يتغير تلقائياً مع إعدادات الهاتف', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 4),
          Text('• يمكنك تغيير السمة في أي وقت من الإعدادات السريعة', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  void _changeTheme(ThemeMode mode) {
    setState(() => _selectedThemeMode = mode);
    ref.read(themeModeProvider.notifier).setThemeMode(mode);
  }
}

class ThemeOption {
  final ThemeMode mode;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  ThemeOption({
    required this.mode,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

final List<Color> _accentColors = [
  Color(0xFF2E7D32), // Green
  Color(0xFF0288D1), // Blue
  Color(0xFFFF9800), // Orange
  Color(0xFFE91E63), // Pink
  Color(0xFF9C27B0), // Purple
  Color(0xFFFF5722), // Deep Orange
  Color(0xFF009688), // Teal
  Color(0xFF673AB7), // Deep Purple
];