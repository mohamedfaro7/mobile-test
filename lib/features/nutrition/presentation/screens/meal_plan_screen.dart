import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  int _selectedDay = 0;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();

  final List<String> _days = ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'];

  final List<Map<String, dynamic>> _meals = [
    {
      'name': 'شوفان مع توت ومكسرات',
      'type': 'إفطار',
      'typeColor': Colors.orange,
      'icon': Icons.wb_sunny,
      'calories': 450,
      'time': '07:30',
      'isCompleted': true,
    },
    {
      'name': 'تفاح مع زبدة فول سوداني',
      'type': 'وجبة خفيفة',
      'typeColor': Colors.amber,
      'icon': Icons.apple,
      'calories': 200,
      'time': '10:30',
      'isCompleted': true,
    },
    {
      'name': 'دجاج مشوي مع كينوا وخضروات',
      'type': 'غداء',
      'typeColor': Colors.blue,
      'icon': Icons.restaurant,
      'calories': 650,
      'time': '13:30',
      'isCompleted': false,
    },
    {
      'name': 'زبادي مع عسل وجوز',
      'type': 'وجبة خفيفة',
      'typeColor': Colors.green,
      'icon': Icons.local_cafe,
      'calories': 180,
      'time': '16:30',
      'isCompleted': false,
    },
    {
      'name': 'سمك سلمون مع بطاطس حلوة',
      'type': 'عشاء',
      'typeColor': Colors.purple,
      'icon': Icons.set_meal,
      'calories': 520,
      'time': '19:30',
      'isCompleted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('خطة الغذاء'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: _showDatePicker),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_days.length, (index) {
                final isSelected = _selectedDay == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(_days[index]),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => _selectedDay = index),
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => setState(() {}),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDailySummary(theme),
                    const SizedBox(height: 24),
                    _buildMacroProgress(theme),
                    const SizedBox(height: 24),
                    _buildWaterIntake(theme),
                    const SizedBox(height: 24),
                    _buildMealsList(theme),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDailySummary(ThemeData theme) {
    final totalCalories = _meals.fold(0, (sum, m) => sum + (m['calories'] as int));
    final completedMeals = _meals.where((m) => m['isCompleted'] as bool).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
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
            child: const Icon(Icons.restaurant_menu, size: 30, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ملخص اليوم', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                Text('$completedMeals/${_meals.length} وجبة مكتملة', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$totalCalories', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
              Text('سعر حراري', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroProgress(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('توزيع الماكروز', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildMacroRing(theme, 'بروتين', 120, 150, Colors.red)),
            const SizedBox(width: 16),
            Expanded(child: _buildMacroRing(theme, 'كربوهيدرات', 200, 250, Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildMacroRing(theme, 'دهون', 65, 73, Colors.orange)),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroRing(ThemeData theme, String label, int current, int target, Color color) {
    final progress = (current / target).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(color),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$current', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: color)),
                    Text('/ $target', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _buildWaterIntake(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.cyan.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.cyan.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.water_drop, color: Colors.cyan, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تتبع الماء', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      Text('7 / 10 كوب', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
              Text('70%', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.cyan)),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation(Colors.cyan),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealsList(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('وجبات اليوم', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        ...List.generate(_meals.length, (index) {
          final meal = _meals[index];
          final isCompleted = meal['isCompleted'] as bool;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCompleted ? Colors.green.withValues(alpha: 0.5) : theme.colorScheme.outline,
                width: isCompleted ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (meal['typeColor'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(meal['icon'] as IconData, color: meal['typeColor'] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              meal['name'] as String,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                          if (isCompleted)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                              child: const Text('مكتمل', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 12)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(meal['time'] as String, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                          const SizedBox(width: 16),
                          Icon(Icons.local_fire_department, size: 14, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text('${meal['calories']} سعر', style: theme.textTheme.labelSmall?.copyWith(color: Colors.orange, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_left, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }
}
