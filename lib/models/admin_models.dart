enum AdminRole {
  superAdmin,
  pharmacyManager,
  subAgent,
}

class AdminUser {
  final String id;
  final String email;
  final String name;
  final AdminRole role;
  final bool isActive;
  final DateTime createdAt;
  final String? phone;
  final WhiteLabelConfig? whiteLabel;
  final int managedPharmaciesCount;
  final int totalOrdersCount;
  final double totalRevenue;

  AdminUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.isActive = true,
    required this.createdAt,
    this.phone,
    this.whiteLabel,
    this.managedPharmaciesCount = 0,
    this.totalOrdersCount = 0,
    this.totalRevenue = 0.0,
  });

  bool get isSuperAdmin => role == AdminRole.superAdmin;
  bool get isPharmacyManager => role == AdminRole.pharmacyManager;
  bool get isSubAgent => role == AdminRole.subAgent;
}

class WhiteLabelConfig {
  final String appName;
  final double commissionPercent;
  final String? deepLinkPrefix;
  final bool isActive;

  WhiteLabelConfig({
    required this.appName,
    this.commissionPercent = 10.0,
    this.deepLinkPrefix,
    this.isActive = true,
  });
}

class AppLockConfig {
  final bool isLocked;
  final String? lockMessage;

  AppLockConfig({this.isLocked = false, this.lockMessage});
}
