import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/pharmacy_models.dart';

class PharmacyDetailScreen extends StatelessWidget {
  final Pharmacy pharmacy;

  const PharmacyDetailScreen({Key? key, required this.pharmacy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pharmacy.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.location_on, 'العنوان', pharmacy.address),
                    _buildInfoRow(Icons.phone, 'الهاتف', pharmacy.phone),
                    _buildInfoRow(Icons.access_time, 'وقت التوصيل', '${pharmacy.deliveryTimeMinutes} دقيقة'),
                    _buildInfoRow(Icons.delivery_dining, 'رسوم التوصيل', '${pharmacy.deliveryFee.toStringAsFixed(0)} ج.س'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('قائمة الأسعار', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...pharmacy.priceList.map((item) => _buildPriceItemCard(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryLight),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          Expanded(child: Text(value, style: const TextStyle(color: AppColors.textPrimary))),
        ],
      ),
    );
  }

  Widget _buildPriceItemCard(PriceListItem item) {
    final hasDiscount = item.discountPercent != null && item.discountPercent! > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: item.isAvailable ? AppColors.success : AppColors.error, shape: BoxShape.circle)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.medicineName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                  Text('الحد الأدنى: ${item.minOrderQuantity} | المتوفر: ${item.stockQuantity}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (hasDiscount)
                  Text('${item.retailPrice.toStringAsFixed(0)} ج.س', style: const TextStyle(color: AppColors.textMuted, fontSize: 12, decoration: TextDecoration.lineThrough)),
                Text('${item.finalPrice.toStringAsFixed(0)} ج.س', style: TextStyle(color: hasDiscount ? AppColors.success : AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
