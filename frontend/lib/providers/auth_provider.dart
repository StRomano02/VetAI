import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'http://192.168.1.39:8000/api/users'));

  String? _token;
  String? _role;

  String? get token => _token;
  String? get role => _role;

  /// Getter per verificare se l'utente è autenticato
  bool get isAuthenticated => _token != null;

  /// Getter per ottenere i dati dell'utente (es. ruolo)
  Map<String, String?>? get userData {
    if (_role != null) {
      return {'role': _role};
    }
    return null;
  }

  /// Metodo per verificare lo stato di login
  Future<void> checkLoginStatus() async {
    try {
      // Recupera token e ruolo da SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      _role = prefs.getString('role');

      // Notifica eventuali listener se l'utente è autenticato
      if (_token != null && _role != null) {
        notifyListeners();
      }
    } catch (e) {
      print('Errore durante la verifica dello stato di login: $e');
    }
  }

  /// Metodo per registrare un utente
  Future<void> signUp(String name, String surname, String email,
      String password, String role) async {
    try {
      // Chiama il service per la registrazione
      await AuthService.signUp(name, surname, email, password, role);

      // Non è necessario aggiornare token/ruolo per ora. Questo avviene al login.
      notifyListeners();
    } catch (e) {
      throw e; // Propaga l'errore per la gestione nel widget
    }
  }

  /// Metodo per effettuare il login
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post('/login/', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data;

        // Salva il token e il ruolo nelle SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('role', data['role']);

        _token = data['token'];
        _role = data['role'];

        notifyListeners(); // Notifica eventuali listener
        return data['role'];
      } else {
        throw Exception('Invalid credentials');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        throw Exception(
            dioError.response?.data['detail'] ?? 'Errore sconosciuto');
      } else {
        throw Exception('Network error: ${dioError.message}');
      }
    }
  }

  /// Metodo per effettuare il logout
  Future<void> logout() async {
    try {
      // Rimuove token e ruolo dalle SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('role');

      _token = null;
      _role = null;

      notifyListeners(); // Notifica eventuali listener per aggiornare lo stato
    } catch (e) {
      print('Errore durante il logout: $e');
    }
  }
}
