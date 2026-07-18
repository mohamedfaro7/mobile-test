import 'package:flutter/material.dart';

class FoodDeliveryTrackingScreen extends StatefulWidget {
  const FoodDeliveryTrackingScreen({super.key});

  @override
  State<FoodDeliveryTrackingScreen> createState() => _FoodDeliveryTrackingScreenState();
}

class _FoodDeliveryTrackingScreenState extends State<FoodDeliveryTrackingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': 'order_1',
      'status': 'في الطريق',
      'statusColor': Colors.orange,
      'items': 'دجاج مشوي مع كينوا، زبادي مع عسل',
      'total': '90.6',
      'time': 'منذ ساعتين',
      'driver': 'محمد علي',
      'progress': 0.7,
    },
  ];

  final List<Map<String, dynamic>> _pastOrders = [
    {
      'id': 'order_3',
      'status': 'تم التوصيل',
      'statusColor': Colors.green,
      'items': 'سمك سلمون مع بطاطس حلوة',
      'total': '75.6',
      'time': 'منذ يوم',
    },
    {
      'id': 'order_4',
      'status': 'تم التوصيل',
      'statusColor': Colors.green,
      'items': 'شوفان مع توت ومكسرات',
      'total': '60.6',
      'time': 'منذ يومين',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('توصيل الوجبات'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: const Icon(Icons.local_shipping), text: 'قيد التوصيل (${_activeOrders.length})'),
            Tab(icon: const Icon(Icons.history), text: 'السابق (${_pastOrders.length})'),
          ],
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          dividerColor: Colors.transparent,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildActiveOrdersTab(theme),
                _buildPastOrdersTab(theme),
              ],
            ),
    );
  }

  Widget _buildActiveOrdersTab(ThemeData theme) {
    if (_activeOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping_outlined, size: 80, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text('لا توجد طلبات نشطة', style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activeOrders.length,
      itemBuilder: (context, index) => _buildOrderCard(_activeOrders[index], true, theme),
    );
  }

  Widget _buildPastOrdersTab(ThemeData theme) {
    if (_pastOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text('لا توجد طلبات سابقة', style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pastOrders.length,
      itemBuilder: (context, index) => _buildOrderCard(_pastOrders[index], false, theme),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, bool isActive, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? (order['statusColor'] as Color).withValues(alpha: 0.5) : theme.colorScheme.outline,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isActive ? (order['statusColor'] as Color).withValues(alpha: 0.1) : theme.colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (order['statusColor'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.receipt, color: order['statusColor'] as Color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('#${order['id']}', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: (order['statusColor'] as Color).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(order['status'] as String, style: theme.textTheme.labelSmall?.copyWith(color: order['statusColor'] as Color, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(order['items'] as String, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${order['total']} ريال', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
                    Text(order['time'] as String, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
          if (isActive) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: order['progress'] as double,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(order['statusColor'] as Color),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 8),
                  if (order['driver'] != null)
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('السائق: ${order['driver']}', style: theme.textTheme.labelMedium),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
