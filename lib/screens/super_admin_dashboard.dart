import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/admin_models.dart';
import '../services/admin_service.dart';
import 'login_screen.dart';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({Key? key}) : super(key: key);

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final adminService = context.watch<AdminService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم المدير'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: () {
              adminService.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.surface,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark])),
                accountName: Text(adminService.currentAdmin?.name ?? 'مدير النظام', style: const TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: Text(adminService.currentAdmin?.email ?? '', style: const TextStyle(color: Colors.white70)),
                currentAccountPicture: const CircleAvatar(backgroundColor: AppColors.primaryLight, child: Icon(Icons.admin_panel_settings, size: 40, color: Colors.white)),
              ),
              _buildDrawerItem(0, Icons.dashboard, 'نظرة عامة'),
              _buildDrawerItem(1, Icons.people, 'المسؤولين'),
              _buildDrawerItem(2, Icons.branding_watermark, 'الوكلاء'),
              _buildDrawerItem(3, Icons.lock, 'قفل التطبيق'),
            ],
          ),
        ),
      ),
      body: _buildBody(adminService),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? AppColors.primaryLight : AppColors.textSecondary),
      title: Text(title, style: TextStyle(color: _selectedIndex == index ? AppColors.primaryLight : AppColors.textPrimary)),
      selected: _selectedIndex == index,
      onTap: () => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildBody(AdminService adminService) {
    switch (_selectedIndex) {
      case 0: return _buildOverviewTab(adminService);
      case 1: return _buildManagersTab(adminService);
      case 2: return _buildAgentsTab(adminService);
      case 3: return _buildLockTab(adminService);
      default: return _buildOverviewTab(adminService);
    }
  }

  Widget _buildOverviewTab(AdminService adminService) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildStatCard('المسؤولين', adminService.pharmacyManagers.length.toString(), Icons.people, AppColors.primary),
              _buildStatCard('الوكلاء', adminService.subAgents.length.toString(), Icons.branding_watermark, AppColors.accent),
              _buildStatCard('النشطين', adminService.admins.where((a) => a.isActive).length.toString(), Icons.check_circle, AppColors.success),
              _buildStatCard('المعطلين', adminService.admins.where((a) => !a.isActive).length.toString(), Icons.cancel, AppColors.error),
            ],
          ),
          const SizedBox(height: 24),
          const Text('إجراءات سريعة', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddManagerDialog(context),
                  icon: const Icon(Icons.person_add),
                  label: const Text('إضافة مسؤول'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddAgentDialog(context),
                  icon: const Icon(Icons.add_business),
                  label: const Text('إضافة وكيل'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildManagersTab(AdminService adminService) {
    final managers = adminService.pharmacyManagers;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: managers.length,
      itemBuilder: (context, index) {
        final manager = managers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: AppColors.primary.withOpacity(0.3), child: Text(manager.name.substring(0, 1), style: const TextStyle(color: AppColors.primaryLight))),
            title: Text(manager.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
            subtitle: Text(manager.email, style: const TextStyle(color: AppColors.textSecondary)),
            trailing: Switch(value: manager.isActive, onChanged: (v) => adminService.toggleAdminStatus(manager.id), activeColor: AppColors.success),
          ),
        );
      },
    );
  }

  Widget _buildAgentsTab(AdminService adminService) {
    final agents = adminService.subAgents;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: agents.length,
      itemBuilder: (context, index) {
        final agent = agents[index];
        final config = agent.whiteLabel;
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.store, color: AppColors.primaryLight),
            ),
            title: Text(config?.appName ?? agent.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agent.name, style: const TextStyle(color: AppColors.textSecondary)),
                Text('العمولة: ${config?.commissionPercent ?? 0}%', style: const TextStyle(color: AppColors.accent, fontSize: 12)),
              ],
            ),
            trailing: Switch(value: agent.isActive, onChanged: (v) => adminService.toggleAdminStatus(agent.id), activeColor: AppColors.success),
          ),
        );
      },
    );
  }

  Widget _buildLockTab(AdminService adminService) {
    final isLocked = adminService.appLockConfig?.isLocked ?? false;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isLocked ? Icons.lock : Icons.lock_open, size: 80, color: isLocked ? AppColors.error : AppColors.success),
          const SizedBox(height: 16),
          Text(isLocked ? 'التطبيق مقفل' : 'التطبيق مفتوح', style: TextStyle(color: isLocked ? AppColors.error : AppColors.success, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () => isLocked ? adminService.unlockApp() : _showLockDialog(context),
              icon: Icon(isLocked ? Icons.lock_open : Icons.lock),
              label: Text(isLocked ? 'فتح التطبيق' : 'قفل التطبيق'),
              style: ElevatedButton.styleFrom(backgroundColor: isLocked ? AppColors.success : AppColors.error, padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ),
        ],
      ),
    );
  }

  void _showLockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('قفل التطبيق', style: TextStyle(color: AppColors.error)),
        content: const Text('هل أنت متأكد من قفل التطبيق لجميع المستخدمين؟', style: TextStyle(color: AppColors.textPrimary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              context.read<AdminService>().lockApp(message: 'التطبيق مقفل للصيانة');
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('قفل'),
          ),
        ],
      ),
    );
  }

  void _showAddManagerDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text('إضافة مسؤول', style: TextStyle(color: AppColors.textPrimary)),
      content: const Text('سيتم فتح نموذج الإضافة', style: TextStyle(color: AppColors.textSecondary)),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق'))],
    ));
  }

  void _showAddAgentDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text('إضافة وكيل', style: TextStyle(color: AppColors.textPrimary)),
      content: const Text('سيتم فتح نموذج إضافة وكيل مخفي', style: TextStyle(color: AppColors.textSecondary)),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق'))],
    ));
  }
}
