import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void login(String email, String password) {
    _currentUser = User(id: '1', email: email, role: 'customer');
    notifyListeners();
  }
}

class User {
  final String id;
  final String email;
  final String role;

  User({this.id, this.email, this.role});
}
