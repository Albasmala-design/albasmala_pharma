import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'البسمله الطبيه',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: Consumer<AuthService>(
          builder: (context, auth, _) {
            if (auth.currentUser == null) return LoginScreen();
            // مؤقتاً: عرض LoginScreen حتى إعداد Firebase
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
