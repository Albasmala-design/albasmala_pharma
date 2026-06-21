class User {
  final String id;
  final String email;
  final String role;
  final String? name;
  final String? phone;

  User({required this.id, required this.email, required this.role, this.name, this.phone});
}

class Pharmacy {
  final String id;
  final String name;
  final String ownerName;
  final String address;
  final String city;
  final String phone;
  final bool isOpen;
  final double rating;
  final int deliveryTimeMinutes;
  final double deliveryFee;
  final List<PriceListItem> priceList;

  Pharmacy({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.address,
    required this.city,
    required this.phone,
    required this.isOpen,
    this.rating = 0.0,
    this.deliveryTimeMinutes = 30,
    this.deliveryFee = 0.0,
    required this.priceList,
  });
}

class PriceListItem {
  final String medicineId;
  final String medicineName;
  final double wholesalePrice;
  final double retailPrice;
  final double? discountPercent;
  final int minOrderQuantity;
  final bool isAvailable;
  final int stockQuantity;

  PriceListItem({
    required this.medicineId,
    required this.medicineName,
    required this.wholesalePrice,
    required this.retailPrice,
    this.discountPercent,
    this.minOrderQuantity = 1,
    this.isAvailable = true,
    this.stockQuantity = 0,
  });

  double get finalPrice {
    if (discountPercent != null && discountPercent! > 0) {
      return retailPrice * (1 - discountPercent! / 100);
    }
    return retailPrice;
  }
}

class OrderItem {
  final String medicineId;
  final String medicineName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  OrderItem({
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });
}

class Order {
  final String id;
  final String pharmacyId;
  final String pharmacyName;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final String status;
  final DateTime createdAt;
  final String? deliveryAddress;

  Order({
    required this.id,
    required this.pharmacyId,
    required this.pharmacyName,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.status,
    required this.createdAt,
    this.deliveryAddress,
  });
}

class DeliveryRoute {
  final String id;
  final String name;
  final List<String> cities;
  final double baseFee;
  final double perKmFee;
  final int estimatedTimeMinutes;
  final bool isActive;

  DeliveryRoute({
    required this.id,
    required this.name,
    required this.cities,
    required this.baseFee,
    required this.perKmFee,
    required this.estimatedTimeMinutes,
    this.isActive = true,
  });
}
