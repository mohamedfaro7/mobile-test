import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitness_app/core/constants/app_constants.dart';
import 'package:fitness_app/shared/widgets/animated_background.dart';

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final categories = [
      {'name': 'البدء', 'icon': Icons.rocket_launch, 'color': Colors.blue, 'articles': ['إنشاء حساب جديد', 'إعداد ملفك الشخصي', 'اختيار خطتك']},
      {'name': 'التغذية والوجبات', 'icon': Icons.restaurant_menu, 'color': Colors.orange, 'articles': ['فهم خطة الغذاء', 'تسجيل الوجبات', 'بدائل الطعام']},
      {'name': 'التمارين واللياقة', 'icon': Icons.fitness_center, 'color': Colors.red, 'articles': ['بدء تمرين جديد', 'فهم خطة التمارين', 'مكتبة التمارين']},
      {'name': 'الاشتراكات والدفع', 'icon': Icons.payment, 'color': Colors.green, 'articles': ['الخطط المتاحة', 'طرق الدفع', 'إدارة الاشتراك']},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('مركز المساعدة')),
      body: AnimatedBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            return ExpansionTile(
              leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: (cat['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)), child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 20)),
              title: Text(cat['name'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              children: (cat['articles'] as List<String>).map((article) => ListTile(
                title: Text(article),
                trailing: const Icon(Icons.chevron_left),
                onTap: () {},
              )).toList(),
            );
          },
        ),
      ),
    );
  }
}
