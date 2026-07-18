import 'package:flutter/material.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool _isLoading = false;
  int _servings = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadMeal();
  }

  Future<void> _loadMeal() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الوجبة'),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(theme),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDescription(theme),
                        const SizedBox(height: 24),
                        _buildMacroCards(theme),
                        const SizedBox(height: 24),
                        _buildServingsSelector(theme),
                        const SizedBox(height: 24),
                        _buildIngredients(theme),
                        const SizedBox(height: 24),
                        _buildInstructions(theme),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم وضع الوجبة كمنجزة')),
          );
        },
        icon: const Icon(Icons.check_circle),
        label: const Text('وضع كمنجز'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🍽️', style: TextStyle(fontSize: 80)),
          SizedBox(height: 16),
          Text('دجاج مشوي مع كينوا وخضروات', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('650 سعر حراري', style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الوصف', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('غداء متوازن عالي البروتين، يحتوي على صدر دجاج مشوي مع كينوا وخضروات طازجة', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildMacroCards(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الماكرونيوترينتس', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildMacroRing(theme, 'بروتين', 45, 150, Colors.red)),
            const SizedBox(width: 16),
            Expanded(child: _buildMacroRing(theme, 'كربوهيدرات', 65, 200, Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildMacroRing(theme, 'دهون', 20, 67, Colors.orange)),
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
                Text('$current', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: color)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildServingsSelector(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('عدد الحصص', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        Row(
          children: [
            IconButton(
              onPressed: _servings > 1 ? () => setState(() => _servings--) : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('$_servings', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            IconButton(
              onPressed: () => setState(() => _servings++),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIngredients(ThemeData theme) {
    final ingredients = [
      {'name': 'صدور دجاج مشوية', 'qty': '${150 * _servings} جم', 'calories': '${220 * _servings} سعر'},
      {'name': 'كينوا', 'qty': '${100 * _servings} جم', 'calories': '${120 * _servings} سعر'},
      {'name': 'بروكلي مطهو', 'qty': '${150 * _servings} جم', 'calories': '${45 * _servings} سعر'},
      {'name': 'زيت زيتون', 'qty': '${10 * _servings} مل', 'calories': '${115 * _servings} سعر'},
      {'name': 'سلطة خضراء', 'qty': '${100 * _servings} جم', 'calories': '${20 * _servings} سعر'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المكونات', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        ...ingredients.map((item) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.restaurant, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name']!, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    Text(item['qty']!, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              Text(item['calories']!, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600, color: Colors.orange)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildInstructions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('طريقة التحضير', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Text(
          'شوي الدجاج مع التوابل، اطهي الكينوا، تبخر البروكلي، اخلط السلطة مع زيت الزيتون. يقدم الدجاج فوق الكينوا مع الخضروات.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildInfoChip(theme, Icons.timer, '35 دقيقة', Colors.blue),
            const SizedBox(width: 8),
            _buildInfoChip(theme, Icons.restaurant_menu, 'متوسط', Colors.orange),
            const SizedBox(width: 8),
            _buildInfoChip(theme, Icons.local_fire_department, '650 سعر', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(ThemeData theme, IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
