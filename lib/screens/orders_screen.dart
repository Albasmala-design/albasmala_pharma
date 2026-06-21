import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الطلبات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrderCard('ORD-001', 'مستودع الخرطوم', '3,500 ج.س', 'قيد التجهيز', AppColors.warning),
          _buildOrderCard('ORD-002', 'مستودع مدني', '2,800 ج.س', 'تم التسليم', AppColors.success),
        ],
      ),
    );
  }

  Widget _buildOrderCard(String id, String pharmacy, String amount, String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(width: 12, height: 12, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
        title: Text(id, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        subtitle: Text(pharmacy, style: const TextStyle(color: AppColors.textSecondary)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount, style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
            Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
