import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthService>().login('test@test.com', 'password');
          },
          child: Text('دخول'),
        ),
      ),
    );
  }
}
