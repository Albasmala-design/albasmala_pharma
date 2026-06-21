import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/pharmacy_models.dart';
import '../services/pharmacy_service.dart';
import 'pharmacy_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PharmacyService _service = PharmacyService();

  @override
  Widget build(BuildContext context) {
    final pharmacies = _service.getSubagentPharmacies();

    return Scaffold(
      appBar: AppBar(title: const Text('خريطة الصيدليات')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pharmacies.length,
        itemBuilder: (context, index) => _buildPharmacyCard(pharmacies[index]),
      ),
    );
  }

  Widget _buildPharmacyCard(Pharmacy pharmacy) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PharmacyDetailScreen(pharmacy: pharmacy)),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: pharmacy.isOpen ? AppColors.success.withOpacity(0.2) : AppColors.error.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.local_pharmacy, color: pharmacy.isOpen ? AppColors.success : AppColors.error, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pharmacy.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(pharmacy.address, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: pharmacy.isOpen ? AppColors.success.withOpacity(0.2) : AppColors.error.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(pharmacy.isOpen ? 'مفتوحة' : 'مغلقة', style: TextStyle(color: pharmacy.isOpen ? AppColors.success : AppColors.error, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(pharmacy.phone, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const Spacer(),
                  const Icon(Icons.star, size: 16, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(pharmacy.rating.toString(), style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
