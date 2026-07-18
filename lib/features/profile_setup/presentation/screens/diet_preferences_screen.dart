import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class DietPreferencesScreen extends ConsumerStatefulWidget {
  const DietPreferencesScreen({super.key});

  @override
  ConsumerState<DietPreferencesScreen> createState() => _DietPreferencesScreenState();
}

class _DietPreferencesScreenState extends ConsumerState<DietPreferencesScreen> {
  final Set<String> _selectedDiets = {};
  bool _isLoading = false;

  final List<Map<String, dynamic>> _dietOptions = [
    {'id': 'none', 'name': 'لا يوجد تفضيل', 'icon': Icons.restaurant, 'color': Colors.grey},
    {'id': 'vegetarian', 'name': 'نباتي', 'icon': Icons.eco, 'color': Colors.green},
    {'id': 'vegan', 'name': 'نباتي صارم', 'icon': Icons.spa, 'color': Colors.lightGreen},
    {'id': 'keto', 'name': 'كيتو', 'icon': Icons.local_fire_department, 'color': Colors.orange},
    {'id': 'high_protein', 'name': 'عالي البروتين', 'icon': Icons.fitness_center, 'color': Colors.red},
    {'id': 'halal', 'name': 'حلال فقط', 'icon': Icons.verified, 'color': Colors.green.shade800},
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
                    Icon(Icons.restaurant_menu, size: 60, color: theme.colorScheme.primary),
                    const SizedBox(height: 24),
                    Text('تفضيلاتك الغذائية', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text('سنساعدك في اختيار الأطعمة المناسبة لك', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
                    const SizedBox(height: 32),
                    ..._dietOptions.map((option) {
                      final isSelected = _selectedDiets.contains(option['id']);
                      final color = option['color'] as Color;
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (option['id'] == 'none') {
                            _selectedDiets.clear();
                            _selectedDiets.add('none');
                          } else {
                            _selectedDiets.remove('none');
                            if (isSelected) _selectedDiets.remove(option['id']);
                            else _selectedDiets.add(option['id'] as String);
                          }
                        }),
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
                              Container(width: 50, height: 50, decoration: BoxDecoration(color: isSelected ? color : color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)), child: Icon(option['icon'] as IconData, size: 24, color: isSelected ? Colors.white : color)),
                              const SizedBox(width: 16),
                              Expanded(child: Text(option['name'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))),
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
                  text: 'التالي',
                  isLoading: _isLoading,
                  onPressed: _handleContinue,
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

  void _handleContinue() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ref.read(storageProvider).saveUserData({'dietPreferences': _selectedDiets.toList()});
      context.go('/profile-setup/activity');
    }
    setState(() => _isLoading = false);
  }
}
