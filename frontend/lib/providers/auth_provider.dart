import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  Map<String, String>? _userData; // Dati del profilo utente

  String? get token => _token;
  Map<String, String>? get userData =>
      _userData; // Getter per i dati del profilo
  bool get isAuthenticated => _token != null;

  // Login dell'utente
  Future<void> login(String username, String password) async {
    // Simula una chiamata API al backend
    if (username == "test" && password == "password") {
      _token = "mock_token"; // Simula un token
      _userData = {
        'username': username,
        'email': 'test@example.com',
      }; // Simula i dati utente ricevuti dal backend

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('username', _userData!['username']!);
      await prefs.setString('email', _userData!['email']!);

      notifyListeners();
    } else {
      throw Exception("Credenziali non valide");
    }
  }

  // Registrazione utente (simile al login)
  Future<void> signUp(String username, String email, String password) async {
    // Simula una chiamata API al backend
    _token = "mock_token";
    _userData = {
      'username': username,
      'email': email,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('username', _userData!['username']!);
    await prefs.setString('email', _userData!['email']!);

    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    _token = null;
    _userData = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  // Controlla se l'utente è già loggato
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    if (_token != null) {
      _userData = {
        'username': prefs.getString('username')!,
        'email': prefs.getString('email')!,
      };
    }
    notifyListeners();
  }
}
