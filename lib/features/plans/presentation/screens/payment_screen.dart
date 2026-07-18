import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/shared/widgets/custom_button.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String planId;

  const PaymentScreen({super.key, required this.planId});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool _isLoading = false;
  bool _agreeToTerms = false;
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  String get _planName {
    switch (widget.planId) {
      case 'individual': return 'فردي';
      case 'family': return 'عائلي';
      case 'corporate': return 'مؤسسي';
      default: return 'خطة';
    }
  }

  double get _planPrice {
    switch (widget.planId) {
      case 'individual': return 99;
      case 'family': return 199;
      case 'corporate': return 1499;
      default: return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الدفع'),
      ),
      body: AnimatedBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.largePadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                  border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.card_membership, color: theme.colorScheme.primary, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_planName, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                          Text('${_planPrice.toStringAsFixed(0)} ريال/شهر', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('بيانات البطاقة', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'اسم حامل البطاقة', prefixIcon: const Icon(Icons.person_outline)),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: 'رقم البطاقة', hintText: '1234 5678 9012 3456', prefixIcon: const Icon(Icons.credit_card)),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: const InputDecoration(labelText: 'تاريخ الانتهاء', hintText: 'MM/YY'),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(labelText: 'CVV'),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                  ),
                  Expanded(
                    child: Text('أوافق على الشروط والأحكام وسياسة الخصوصية', style: theme.textTheme.bodySmall),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'ادفع ${_planPrice.toStringAsFixed(0)} ريال',
                isLoading: _isLoading,
                onPressed: _agreeToTerms ? _processPayment : null,
                isFullWidth: true,
                icon: Icons.payment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/dashboard');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الدفع بنجاح!'), backgroundColor: Colors.green),
      );
    }
    setState(() => _isLoading = false);
  }
}
