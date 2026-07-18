import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تغيير كلمة المرور'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(theme),
              const SizedBox(height: 32),
              _buildPasswordFields(theme),
              const SizedBox(height: 32),
              _buildRequirements(theme),
              const SizedBox(height: 32),
              _buildChangeButton(theme),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.lock_outline, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 24),
        Text('تغيير كلمة المرور', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text('أدخل كلمة المرور الحالية وكلمة المرور الجديدة', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildPasswordFields(ThemeData theme) {
    return Column(
      children: [
        TextFormField(
          controller: _currentPasswordController,
          obscureText: _obscureCurrent,
          decoration: InputDecoration(
            labelText: 'كلمة المرور الحالية',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscureCurrent ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'مطلوب';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _newPasswordController,
          obscureText: _obscureNew,
          decoration: InputDecoration(
            labelText: 'كلمة المرور الجديدة',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscureNew ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'مطلوب';
            if (value.length < 8) return 'يجب أن تكون 8 أحرف على الأقل';
            if (!RegExp(r'[A-Z]').hasMatch(value)) return 'يجب أن تحتوي على حرف كبير واحد على الأقل';
            if (!RegExp(r'[a-z]').hasMatch(value)) return 'يجب أن تحتوي على حرف صغير واحد على الأقل';
            if (!RegExp(r'[0-9]').hasMatch(value)) return 'يجب أن تحتوي على رقم واحد على الأقل';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirm,
          decoration: InputDecoration(
            labelText: 'تأكيد كلمة المرور الجديدة',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'مطلوب';
            if (value != _newPasswordController.text) return 'كلمة المرور غير متطابقة';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRequirements(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text('متطلبات كلمة المرور', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          _buildRequirementItem(theme, '8 أحرف على الأقل', true),
          const SizedBox(height: 8),
          _buildRequirementItem(theme, 'حرف كبير واحد على الأقل (A-Z)', true),
          const SizedBox(height: 8),
          _buildRequirementItem(theme, 'حرف صغير واحد على الأقل (a-z)', true),
          const SizedBox(height: 8),
          _buildRequirementItem(theme, 'رقم واحد على الأقل (0-9)', true),
          const SizedBox(height: 8),
          _buildRequirementItem(theme, 'رمز خاص واحد على الأقل (!@#\$%^&*)', false),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(ThemeData theme, String text, bool met) {
    return Row(
      children: [
        Icon(met ? Icons.check_circle : Icons.radio_button_unchecked, size: 18, color: met ? Colors.green : theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(text, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildChangeButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _handleChangePassword,
        icon: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.lock_reset),
        label: Text(_isLoading ? 'جاري التغيير...' : 'تغيير كلمة المرور'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Future<void> _handleChangePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    }
  }
}
