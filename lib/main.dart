import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'services/auth_service.dart';
import 'services/admin_service.dart';
import 'screens/login_screen.dart';
import 'screens/super_admin_dashboard.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => AdminService()),
      ],
      child: MaterialApp(
        title: 'Albasmala Pharma',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final adminService = context.watch<AdminService>();

    if (adminService.currentAdmin != null && adminService.isSuperAdmin) {
      return const SuperAdminDashboard();
    }
    if (authService.currentUser != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}
