class User {
  final String id;
  final String email;
  final String role;

  User({required this.id, required this.email, required this.role});
}

class AuthService {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // TODO: Implement actual authentication
    _currentUser = User(id: '1', email: email, role: 'user');
    return true;
  }

  void logout() {
    _currentUser = null;
  }
}
