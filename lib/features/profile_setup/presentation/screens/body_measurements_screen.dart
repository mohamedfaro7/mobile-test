import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class BodyMeasurementsScreen extends ConsumerStatefulWidget {
  const BodyMeasurementsScreen({super.key});

  @override
  ConsumerState<BodyMeasurementsScreen> createState() => _BodyMeasurementsScreenState();
}

class _BodyMeasurementsScreenState extends ConsumerState<BodyMeasurementsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'male';
  bool _isLoading = false;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Icon(Icons.monitor_weight, size: 60, color: theme.colorScheme.primary),
                  const SizedBox(height: 24),
                  Text('قياسات الجسم', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('ساعدنا في حساب احتياجاتك اليومية', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedGender = 'male'),
                          child: Container(
                            padding: const EdgeInsets.all(AppConstants.largePadding),
                            decoration: BoxDecoration(
                              color: _selectedGender == 'male' ? theme.colorScheme.primary.withValues(alpha: 0.15) : theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                              border: Border.all(color: _selectedGender == 'male' ? theme.colorScheme.primary : theme.colorScheme.outline, width: _selectedGender == 'male' ? 2 : 1),
                            ),
                            child: Column(children: [Icon(Icons.male, size: 40, color: _selectedGender == 'male' ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant), const SizedBox(height: 8), Text('ذكر', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedGender = 'female'),
                          child: Container(
                            padding: const EdgeInsets.all(AppConstants.largePadding),
                            decoration: BoxDecoration(
                              color: _selectedGender == 'female' ? theme.colorScheme.tertiary.withValues(alpha: 0.15) : theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                              border: Border.all(color: _selectedGender == 'female' ? theme.colorScheme.tertiary : theme.colorScheme.outline, width: _selectedGender == 'female' ? 2 : 1),
                            ),
                            child: Column(children: [Icon(Icons.female, size: 40, color: _selectedGender == 'female' ? theme.colorScheme.tertiary : theme.colorScheme.onSurfaceVariant), const SizedBox(height: 8), Text('أنثى', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600))]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: TextFormField(controller: _heightController, decoration: const InputDecoration(labelText: 'الطول (سم)', hintText: '175'), keyboardType: TextInputType.number, validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null)),
                      const SizedBox(width: 16),
                      Expanded(child: TextFormField(controller: _weightController, decoration: const InputDecoration(labelText: 'الوزن (كجم)', hintText: '70'), keyboardType: TextInputType.number, validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(controller: _ageController, decoration: const InputDecoration(labelText: 'العمر', hintText: '25'), keyboardType: TextInputType.number, validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null),
                  const SizedBox(height: 32),
                  CustomButton(text: 'التالي', isLoading: _isLoading, onPressed: _handleContinue, isFullWidth: true, icon: Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleContinue() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      ref.read(storageProvider).saveUserData({
        'height': double.parse(_heightController.text),
        'weight': double.parse(_weightController.text),
        'age': int.parse(_ageController.text),
        'gender': _selectedGender,
      });
      context.go('/profile-setup/goals');
    }
    setState(() => _isLoading = false);
  }
}
