import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D7377);
  static const Color primaryLight = Color(0xFF14FFEC);
  static const Color background = Color(0xFF0A192F);
  static const Color surface = Color(0xFF112240);
  static const Color textPrimary = Color(0xFFCCD6F6);
  static const Color textSecondary = Color(0xFF8892B0);
  static const Color accent = Color(0xFFFFD700);
  static const Color error = Color(0xFFE84545);
  static const Color success = Color(0xFF00C853);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
    );
  }
}
