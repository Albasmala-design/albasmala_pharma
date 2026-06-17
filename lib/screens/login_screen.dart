import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('البسمله الطبيه - تسجيل الدخول')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🏥 Albasmala Pharma', style: TextStyle(fontSize: 24)),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'كلمة المرور'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('خطأ: ${e.message}')),
                    );
                  }
                },
                child: Text('دخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
