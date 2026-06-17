import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/user.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  User? get currentUser => _currentUser;

  AuthService() {
    _auth.authStateChanges().listen((user) {
      _currentUser = user != null ? User(id: user.uid, email: user.email!, role: 'customer') : null;
      notifyListeners();
    });
  }
}
