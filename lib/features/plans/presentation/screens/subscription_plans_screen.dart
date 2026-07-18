import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class SubscriptionPlansScreen extends ConsumerStatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  ConsumerState<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends ConsumerState<SubscriptionPlansScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر خطتك'),
      ),
      body: AnimatedBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          children: [
            _buildPlanCard(
              context,
              title: 'فردي',
              description: 'خطة مثالية لشخص واحد يريد تحقيق أهدافه',
              price: 99,
              period: 'شهر',
              features: ['خطة غذائية مخصصة', 'خطة تمارين شخصية', 'تتبع التقدم', 'مكتبة تمارين'],
              isPopular: true,
              planId: 'individual',
            ),
            _buildPlanCard(
              context,
              title: 'عائلي',
              description: 'للعائلات حتى 5 أشخاص مع حسابات منفصلة',
              price: 199,
              period: 'شهر',
              features: ['خطط غذائية للعائلة', 'خطط تمارين للجميع', 'مجتمع دعم', 'استشارة مدرب'],
              isPopular: false,
              planId: 'family',
            ),
            _buildPlanCard(
              context,
              title: 'مؤسسي',
              description: 'للشركات والمؤسسات حتى 50 موظف',
              price: 1499,
              period: 'شهر',
              features: ['خطط غذائية للموظفين', 'تقارير إدارية', 'مدرب مخصص', 'لوحة تحكم'],
              isPopular: false,
              planId: 'corporate',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String description,
    required double price,
    required String period,
    required List<String> features,
    required bool isPopular,
    required String planId,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.largePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
        border: Border.all(
          color: isPopular ? theme.colorScheme.primary : theme.colorScheme.outline,
          width: isPopular ? 2 : 1,
        ),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.largeBorderRadius)),
              ),
              child: Text(
                'الأكثر شعبية',
                style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(description, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 16),
                Text(
                  '$price ريال/$period',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 16),
                ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 20, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(child: Text(f, style: theme.textTheme.bodyMedium)),
                    ],
                  ),
                )),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'اختر هذه الخطة',
                  isLoading: _isLoading,
                  onPressed: () => context.push('/payment/$planId'),
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
