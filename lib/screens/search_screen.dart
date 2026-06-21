import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/pharmacy_models.dart';
import '../services/pharmacy_service.dart';
import 'pharmacy_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PharmacyService _service = PharmacyService();
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results = _query.isEmpty ? [] : _service.searchMedicineAcrossSubagents(_query);

    return Scaffold(
      appBar: AppBar(title: const Text('بحث عن دواء')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.surface,
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'اكتب اسم الدواء...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryLight),
                suffixIcon: _query.isNotEmpty ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                  onPressed: () { _controller.clear(); setState(() => _query = ''); },
                ) : null,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: _query.isEmpty
              ? const Center(child: Text('ابحث عن دواء', style: TextStyle(color: AppColors.textSecondary)))
              : results.isEmpty
                ? const Center(child: Text('لا توجد نتائج', style: TextStyle(color: AppColors.textSecondary)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final result = results[index];
                      final pharmacy = result['subagent'] as Pharmacy;
                      final priceItem = result['priceItem'] as PriceListItem;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PharmacyDetailScreen(pharmacy: pharmacy))),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                                  child: const Icon(Icons.medication, color: AppColors.primaryLight),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(priceItem.medicineName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                                      Text(pharmacy.name, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (priceItem.discountPercent != null && priceItem.discountPercent! > 0)
                                      Text('${priceItem.retailPrice.toStringAsFixed(0)} ج.س', style: const TextStyle(color: AppColors.textMuted, fontSize: 12, decoration: TextDecoration.lineThrough)),
                                    Text('${priceItem.finalPrice.toStringAsFixed(0)} ج.س', style: const TextStyle(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
