import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token; // Token di autenticazione
  Map<String, String>? _userData; // Dati utente: nome, cognome, email, ruolo

  String? get token => _token;
  Map<String, String>? get userData => _userData;
  bool get isAuthenticated => _token != null;

  // Login con email e password
  Future<String> login(String email, String password) async {
    // Simula una chiamata API per autenticazione
    if (email == "vet@example.com" && password == "password") {
      _token = "mock_token_vet";
      _userData = {
        'nome': 'Mario',
        'cognome': 'Rossi',
        'email': email,
        'role': 'vet',
      };
    } else if (email == "client@example.com" && password == "password") {
      _token = "mock_token_client";
      _userData = {
        'nome': 'Anna',
        'cognome': 'Bianchi',
        'email': email,
        'role': 'client',
      };
    } else {
      throw Exception("Credenziali non valide");
    }

    // Salva il token e i dati utente nelle SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('nome', _userData!['nome']!);
    await prefs.setString('cognome', _userData!['cognome']!);
    await prefs.setString('email', _userData!['email']!);
    await prefs.setString('role', _userData!['role']!);

    notifyListeners();
    return _userData!['role']!; // Ritorna il ruolo dell'utente
  }

  // Registrazione utente
  Future<void> signUp(String nome, String cognome, String email,
      String password, String role) async {
    // Simula una chiamata API per registrare l'utente
    _token = "mock_token";
    _userData = {
      'nome': nome,
      'cognome': cognome,
      'email': email,
      'role': role,
    };

    // Salva i dati nelle SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('nome', nome);
    await prefs.setString('cognome', cognome);
    await prefs.setString('email', email);
    await prefs.setString('role', role);

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
        'nome': prefs.getString('nome')!,
        'cognome': prefs.getString('cognome')!,
        'email': prefs.getString('email')!,
        'role': prefs.getString('role')!,
      };
    }
    notifyListeners();
  }
}
