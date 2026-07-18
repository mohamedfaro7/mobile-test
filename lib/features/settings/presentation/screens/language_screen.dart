import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ar';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _languages = [
    {'code': 'ar', 'name': 'العربية', 'nativeName': 'العربية', 'flag': '🇸🇦', 'isRTL': true},
    {'code': 'en', 'name': 'English', 'nativeName': 'English', 'flag': '🇺🇸', 'isRTL': false},
    {'code': 'fr', 'name': 'Français', 'nativeName': 'Français', 'flag': '🇫🇷', 'isRTL': false},
    {'code': 'es', 'name': 'Español', 'nativeName': 'Español', 'flag': '🇪🇸', 'isRTL': false},
    {'code': 'de', 'name': 'Deutsch', 'nativeName': 'Deutsch', 'flag': '🇩🇪', 'isRTL': false},
    {'code': 'tr', 'name': 'Türkçe', 'nativeName': 'Türkçe', 'flag': '🇹🇷', 'isRTL': false},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('اللغة'),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeader(theme),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _languages.length,
              itemBuilder: (context, index) => _buildLanguageCard(_languages[index], theme),
            ),
          ),
          _buildInfoCard(theme),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.language, size: 24, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اختر لغتك المفضلة', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('سيتم تطبيق التغيير فوراً', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCurrentLanguage(theme),
        ],
      ),
    );
  }

  Widget _buildCurrentLanguage(ThemeData theme) {
    final currentLang = _languages.firstWhere((l) => l['code'] == _selectedLanguage, orElse: () => _languages.first);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Text(currentLang['flag'] as String, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currentLang['nativeName'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                Text(currentLang['name'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('اللغة الحالية', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(Map<String, dynamic> lang, ThemeData theme) {
    final isSelected = _selectedLanguage == lang['code'];

    return GestureDetector(
      onTap: () => _selectLanguage(lang['code'] as String),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(lang['flag'] as String, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lang['nativeName'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface)),
                  Text(lang['name'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            if (lang['isRTL'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                child: Text('RTL', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
              ),
            const SizedBox(width: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text('ملاحظة', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
            ],
          ),
          const SizedBox(height: 8),
          Text('• يتم حفظ تفضيل اللغة محلياً', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 4),
          Text('• بعض النصوص قد تحتاج إعادة تشغيل التطبيق', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  void _selectLanguage(String code) async {
    if (_selectedLanguage == code) return;

    setState(() {
      _selectedLanguage = code;
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(code == 'ar' ? 'تم تغيير اللغة إلى العربية' : 'Language changed'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
