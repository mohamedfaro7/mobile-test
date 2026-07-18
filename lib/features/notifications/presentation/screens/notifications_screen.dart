import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'وقت الغداء!',
      'body': 'حان وقت وجبة الدجاج المشوي مع الكينوا',
      'icon': '🍽️',
      'time': 'منذ 30 دقيقة',
      'isRead': false,
      'color': Colors.orange,
    },
    {
      'id': '2',
      'title': 'تمرين الظهر والبايسبس',
      'body': 'حان وقت تمرينك، لا تتكاسل!',
      'icon': '💪',
      'time': 'منذ ساعتين',
      'isRead': false,
      'color': Colors.blue,
    },
    {
      'id': '3',
      'title': 'تذكير بشرب الماء 💧',
      'body': 'لقد شربت 1.5 لتر اليوم، هدفك 2.5 لتر',
      'icon': '💧',
      'time': 'منذ 4 ساعات',
      'isRead': true,
      'color': Colors.cyan,
    },
    {
      'id': '4',
      'title': 'إنجاز جديد! 🏆',
      'body': 'أكملت أسبوعين متتاليين من التمارين!',
      'icon': '🏆',
      'time': 'منذ يوم',
      'isRead': true,
      'color': Colors.amber,
    },
    {
      'id': '5',
      'title': 'تحديث التقدم الأسبوعي',
      'body': 'فقدت 0.8 كجم هذا الأسبوع! رائع!',
      'icon': '📊',
      'time': 'منذ يومين',
      'isRead': true,
      'color': Colors.green,
    },
    {
      'id': '6',
      'title': 'اشتراكك سينتهي قريباً ⏰',
      'body': 'ينتهي اشتراكك خلال 3 أيام، جدد الآن',
      'icon': '⏰',
      'time': 'منذ 7 أيام',
      'isRead': false,
      'color': Colors.red,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('الإشعارات'),
        actions: [
          IconButton(icon: const Icon(Icons.done_all), onPressed: _markAllAsRead, tooltip: 'تعليم الكل كمقروء'),
          IconButton(icon: const Icon(Icons.delete_sweep), onPressed: _clearAll, tooltip: 'مسح الكل'),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.inbox), text: 'الكل'),
            Tab(icon: Icon(Icons.markunread), text: 'غير مقروءة'),
            Tab(icon: Icon(Icons.history), text: 'الأرشيف'),
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
                _buildNotificationsList(_notifications),
                _buildNotificationsList(_notifications.where((n) => !(n['isRead'] as bool)).toList()),
                _buildNotificationsList(_notifications.where((n) => n['isRead'] as bool).toList()),
              ],
            ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off, size: 80, color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text('لا توجد إشعارات', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            Text('ستظهر إشعاراتك هنا عند وصولها', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) => _buildNotificationCard(notifications[index]),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final theme = Theme.of(context);
    final isRead = notification['isRead'] as bool;

    return Dismissible(
      key: Key(notification['id'] as String),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteNotification(notification['id'] as String),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRead ? theme.colorScheme.surface : theme.colorScheme.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isRead ? theme.colorScheme.outline : theme.colorScheme.primary.withValues(alpha: 0.3),
            width: isRead ? 1 : 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (notification['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text(notification['icon'] as String, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'] as String,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['body'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(notification['time'] as String, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifications) {
        n['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعليم جميع الإشعارات كمقروءة'), backgroundColor: Colors.green),
    );
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مسح جميع الإشعارات'),
        content: const Text('هل أنت متأكد من مسح جميع الإشعارات؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              setState(() => _notifications.clear());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم مسح جميع الإشعارات'), backgroundColor: Colors.red),
              );
            },
            child: const Text('مسح', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _deleteNotification(String id) {
    setState(() => _notifications.removeWhere((n) => n['id'] == id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف الإشعار'), backgroundColor: Colors.red),
    );
  }
}
