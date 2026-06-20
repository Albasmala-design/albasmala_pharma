import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String role;

  User({required this.id, required this.email, required this.role});
}

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    _currentUser = User(id: '1', email: email, role: 'user');
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
