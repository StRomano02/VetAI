import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  Map<String, String>? _userData; // Dati del profilo utente

  String? get token => _token;
  Map<String, String>? get userData => _userData;
  bool get isAuthenticated => _token != null;

  // Login dell'utente
  Future<String> login(String username, String password) async {
    // Simula una chiamata API al backend con username e password
    if (username == "vet" && password == "password") {
      _token = "mock_token_vet";
      _userData = {
        'username': username,
        'email': 'vet@example.com',
        'role': 'vet',
      };
    } else if (username == "client" && password == "password") {
      _token = "mock_token_client";
      _userData = {
        'username': username,
        'email': 'client@example.com',
        'role': 'client',
      };
    } else {
      throw Exception("Credenziali non valide");
    }

    // Salva il token e i dati utente nelle SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('username', _userData!['username']!);
    await prefs.setString('email', _userData!['email']!);
    await prefs.setString('role', _userData!['role']!);

    notifyListeners();
    return _userData!['role']!; // Ritorna il ruolo dell'utente
  }

  // Registrazione utente (simile al login)
  // Aggiungi un nuovo parametro per il ruolo
  Future<void> signUp(
      String username, String email, String password, String role) async {
    // Simula una chiamata API al backend per registrare l'utente
    _token = "mock_token";
    _userData = {
      'username': username,
      'email': email,
      'role': role, // Memorizza il ruolo scelto
    };

    // Salva i dati nelle SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('username', _userData!['username']!);
    await prefs.setString('email', _userData!['email']!);
    await prefs.setString('role', role); // Salva anche il ruolo

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
        'role': prefs.getString('role')!,
      };
    }
    notifyListeners();
  }
}
