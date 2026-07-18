import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

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
        title: const Text('إدارة المستخدمين'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.people), text: 'الكل'),
            Tab(icon: Icon(Icons.check_circle), text: 'نشط'),
            Tab(icon: Icon(Icons.block), text: 'موقوف'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('إضافة مستخدم جديد')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'ابحث بالاسم أو البريد...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUsersList(),
                _buildUsersList(),
                _buildUsersList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    final users = [
      {'name': 'أحمد محمد', 'email': 'ahmed@example.com', 'status': 'نشط'},
      {'name': 'سارة علي', 'email': 'sara@example.com', 'status': 'نشط'},
      {'name': 'محمد حسن', 'email': 'mohamed@example.com', 'status': 'منتهي'},
      {'name': 'فاطمة الزهراء', 'email': 'fatima@example.com', 'status': 'نشط'},
      {'name': 'خالد عبدالله', 'email': 'khaled@example.com', 'status': 'موقوف'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(user['name']![0]),
            ),
            title: Text(user['name']!),
            subtitle: Text(user['email']!),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: user['status'] == 'نشط'
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.red.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user['status']!,
                style: TextStyle(
                  color: user['status'] == 'نشط' ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
