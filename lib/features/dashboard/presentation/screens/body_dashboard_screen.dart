import 'package:flutter/material.dart';

class BodyDashboardScreen extends StatefulWidget {
  const BodyDashboardScreen({super.key});

  @override
  State<BodyDashboardScreen> createState() => _BodyDashboardScreenState();
}

class _BodyDashboardScreenState extends State<BodyDashboardScreen> {
  bool _isLoading = false;
  double _weight = 82.5;
  double _bodyFat = 18.5;
  double _muscleMass = 38.0;
  double _bmi = 25.5;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الجسم'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showAddMeasurementDialog),
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCurrentStats(theme),
                    const SizedBox(height: 24),
                    _buildBodyComposition(theme),
                    const SizedBox(height: 24),
                    _buildBodyMeasurements(theme),
                    const SizedBox(height: 24),
                    _buildGoalsProgress(theme),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddMeasurementDialog,
        icon: const Icon(Icons.add),
        label: const Text('إضافة قياس'),
      ),
    );
  }

  Widget _buildCurrentStats(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('القياسات الحالية', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard(theme, 'الوزن', '${_weight.toStringAsFixed(1)} كجم', Icons.monitor_weight, Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard(theme, 'الدهون', '${_bodyFat.toStringAsFixed(1)}%', Icons.water_drop, Colors.red)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard(theme, 'العضلات', '${_muscleMass.toStringAsFixed(1)} كجم', Icons.fitness_center, Colors.green)),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard(theme, 'BMI', _bmi.toStringAsFixed(1), Icons.calculate, Colors.orange)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildBodyComposition(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('تركيب الجسم', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildGaugeCard(theme, 'الدهون', _bodyFat, '%', Colors.red)),
            const SizedBox(width: 12),
            Expanded(child: _buildGaugeCard(theme, 'العضلات', _muscleMass, 'كجم', Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _buildGaugeCard(theme, 'الماء', 60.0, '%', Colors.cyan)),
          ],
        ),
      ],
    );
  }

  Widget _buildGaugeCard(ThemeData theme, String label, double value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: CircularProgressIndicator(
              value: (value / 100).clamp(0.0, 1.0),
              strokeWidth: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(color),
              strokeCap: StrokeCap.round,
            ),
          ),
          const SizedBox(height: 8),
          Text('${value.toStringAsFixed(1)}$unit', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: color)),
          Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildBodyMeasurements(ThemeData theme) {
    final measurements = [
      {'label': 'الخصر', 'value': '88', 'unit': 'سم', 'icon': Icons.straighten, 'color': Colors.blue},
      {'label': 'الورك', 'value': '96', 'unit': 'سم', 'icon': Icons.crop_rotate, 'color': Colors.purple},
      {'label': 'الصدر', 'value': '102', 'unit': 'سم', 'icon': Icons.favorite, 'color': Colors.red},
      {'label': 'الكتف', 'value': '110', 'unit': 'سم', 'icon': Icons.accessibility_new, 'color': Colors.pink},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('قياسات الجسم', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.2),
          itemCount: measurements.length,
          itemBuilder: (context, index) {
            final m = measurements[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(m['icon'] as IconData, color: m['color'] as Color, size: 30),
                  const SizedBox(height: 8),
                  Text('${m['value']} ${m['unit']}', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  Text(m['label'] as String, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGoalsProgress(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('تقدم الأهداف', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        _buildGoalCard(theme, 'فقدان الوزن', 'الوصول لـ 75 كجم', 0.65, 'متبقي 7.5 كجم', Colors.green),
        const SizedBox(height: 12),
        _buildGoalCard(theme, 'نسبة الدهون', 'الوصول لـ 12%', 0.72, 'متبقي 3%', Colors.orange),
        const SizedBox(height: 12),
        _buildGoalCard(theme, 'الكتلة العضلية', 'الوصول لـ 42 كجم', 0.58, 'متبقي 3 كجم', Colors.blue),
      ],
    );
  }

  Widget _buildGoalCard(ThemeData theme, String title, String target, double progress, String remaining, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              Text(target, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(progress * 100).round()}% مكتمل', style: theme.textTheme.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w600)),
              Text(remaining, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddMeasurementDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Text('إضافة قياس جديد', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              _buildMeasurementForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: TextField(decoration: const InputDecoration(labelText: 'الوزن (كجم)', border: OutlineInputBorder()))),
            const SizedBox(width: 12),
            Expanded(child: TextField(decoration: const InputDecoration(labelText: 'الدهون (%)', border: OutlineInputBorder()))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: TextField(decoration: const InputDecoration(labelText: 'العضلات (كجم)', border: OutlineInputBorder()))),
            const SizedBox(width: 12),
            Expanded(child: TextField(decoration: const InputDecoration(labelText: 'الخصر (سم)', border: OutlineInputBorder()))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: TextField(decoration: const InputDecoration(labelText: 'الورك (سم)', border: OutlineInputBorder()))),
            const SizedBox(width: 12),
            Expanded(child: TextField(decoration: const InputDecoration(labelText: 'الصدر (سم)', border: OutlineInputBorder()))),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حفظ القياس بنجاح'), backgroundColor: Colors.green),
              );
            },
            child: const Text('حفظ القياس'),
          ),
        ),
      ],
    );
  }
}
