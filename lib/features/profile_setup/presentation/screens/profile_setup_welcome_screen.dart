import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/core/providers/app_providers.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class ProfileSetupWelcomeScreen extends ConsumerStatefulWidget {
  const ProfileSetupWelcomeScreen({super.key});

  @override
  ConsumerState<ProfileSetupWelcomeScreen> createState() => _ProfileSetupWelcomeScreenState();
}

class _ProfileSetupWelcomeScreenState extends ConsumerState<ProfileSetupWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                    ),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(Icons.fitness_center, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 32),
                Text(
                  'مرحباً بك في FitLife!',
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'دعنا نخصص تجربتك لتناسب أهدافك',
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CustomButton(
                  text: 'ابدأ الإعداد',
                  onPressed: () => context.go('/profile-setup/measurements'),
                  isFullWidth: true,
                  icon: Icons.arrow_forward,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/dashboard'),
                  child: const Text('تخطي'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
