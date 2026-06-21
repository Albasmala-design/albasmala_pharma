import '../models/pharmacy_models.dart';

class PharmacyService {
  List<Pharmacy> getSubagentPharmacies() {
    return [
      Pharmacy(
        id: 'subagent_1',
        name: 'مستودع الأدوية المركزي - الخرطوم',
        ownerName: 'أحمد محمد',
        address: 'شارع الجمهورية، الخرطوم',
        city: 'الخرطوم',
        phone: '+249912345678',
        isOpen: true,
        rating: 4.8,
        deliveryTimeMinutes: 120,
        deliveryFee: 500.0,
        priceList: [
          PriceListItem(medicineId: '1', medicineName: 'باراسيتامول 500mg', wholesalePrice: 8.0, retailPrice: 15.0, discountPercent: 10.0, minOrderQuantity: 100, stockQuantity: 5000),
          PriceListItem(medicineId: '2', medicineName: 'أموكسيسيلين 500mg', wholesalePrice: 18.0, retailPrice: 35.0, discountPercent: 15.0, minOrderQuantity: 50, stockQuantity: 2000),
          PriceListItem(medicineId: '3', medicineName: 'إيبوبروفين 400mg', wholesalePrice: 12.0, retailPrice: 22.0, discountPercent: 5.0, minOrderQuantity: 100, stockQuantity: 3000),
        ],
      ),
      Pharmacy(
        id: 'subagent_2',
        name: 'مستودع الأدوية - مدني',
        ownerName: 'خالد عمر',
        address: 'شارع النيل، مدني',
        city: 'مدني',
        phone: '+249923456789',
        isOpen: true,
        rating: 4.5,
        deliveryTimeMinutes: 180,
        deliveryFee: 750.0,
        priceList: [
          PriceListItem(medicineId: '1', medicineName: 'باراسيتامول 500mg', wholesalePrice: 9.0, retailPrice: 16.0, discountPercent: 5.0, minOrderQuantity: 50, stockQuantity: 3000),
          PriceListItem(medicineId: '2', medicineName: 'أموكسيسيلين 500mg', wholesalePrice: 20.0, retailPrice: 38.0, discountPercent: 10.0, minOrderQuantity: 30, stockQuantity: 1500),
        ],
      ),
    ];
  }

  List<Map<String, dynamic>> searchMedicineAcrossSubagents(String query) {
    final pharmacies = getSubagentPharmacies();
    List<Map<String, dynamic>> results = [];
    for (var pharmacy in pharmacies) {
      for (var item in pharmacy.priceList) {
        if (item.medicineName.toLowerCase().contains(query.toLowerCase()) && item.isAvailable) {
          results.add({'subagent': pharmacy, 'priceItem': item});
        }
      }
    }
    results.sort((a, b) => (a['priceItem'] as PriceListItem).finalPrice.compareTo((b['priceItem'] as PriceListItem).finalPrice));
    return results;
  }

  List<DeliveryRoute> getDeliveryRoutes() {
    return [
      DeliveryRoute(id: 'route_1', name: 'الخرطوم - أم درمان - بحري', cities: ['الخرطوم', 'أم درمان', 'بحري'], baseFee: 500.0, perKmFee: 50.0, estimatedTimeMinutes: 120),
      DeliveryRoute(id: 'route_2', name: 'الخرطوم - مدني - سنار', cities: ['الخرطوم', 'مدني', 'سنار'], baseFee: 1500.0, perKmFee: 30.0, estimatedTimeMinutes: 240),
    ];
  }
}
