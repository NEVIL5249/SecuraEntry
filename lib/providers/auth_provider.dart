import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  AuthProvider() {
    _getCurrentUser();
  }

  User? get user => _user;

  // Get current Firebase user
  void _getCurrentUser() {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  // Register new user
  Future<String?> register(String email, String password, String name, String role) async {
    try {
      String? result = await _authService.registerUser(email, password, name, role);
      if (result == null) {
        _getCurrentUser();
      }
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  // Login existing user
  Future<String?> login(String email, String password) async {
    try {
      String? result = await _authService.loginUser(email, password);
      if (result == null) {
        _getCurrentUser();
      }
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  // Logout user
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
