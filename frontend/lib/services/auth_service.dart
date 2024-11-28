import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.39:8000/api/users',
      connectTimeout: Duration(milliseconds: 15000),
      receiveTimeout: Duration(milliseconds: 15000),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(LogInterceptor(
      responseBody: true, requestBody: true)); // Logging per debug

  // Metodo per la registrazione
  static Future<void> signUp(String name, String surname, String email,
      String password, String role) async {
    try {
      print(
          "Registrazione: Dati inviati -> Name: $name, Surname $surname, Email: $email, Role: $role");

      final response = await _dio.post('/register/', data: {
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'role': role,
      });

      // Verifica la risposta
      if (response.statusCode == 201) {
        print("Registrazione avvenuta con successo: ${response.data}");
      } else {
        print("Errore durante la registrazione. Stato: ${response.statusCode}");
        throw Exception('Errore durante la registrazione');
      }
    } on DioError catch (dioError) {
      // Gestione degli errori Dio
      if (dioError.response != null) {
        print(
            "Errore dal server durante la registrazione: ${dioError.response?.data}");
        throw Exception(
            dioError.response?.data['detail'] ?? 'Errore di registrazione');
      } else {
        print("Errore di rete durante la registrazione: ${dioError.message}");
        throw Exception('Errore di rete');
      }
    }
  }

  // Metodo per il login
  static Future<bool> login(String email, String password) async {
    try {
      print("Login: Dati inviati -> Email: $email");

      final response = await _dio.post('/login/', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Salva il token e il ruolo nelle SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data['token']);
        await prefs.setString(
            "role", response.data['role']); // Role direttamente dalla risposta
        print(
            "Login riuscito: Token salvato -> ${response.data['token']}, Role: ${response.data['role']}");
        return true;
      } else {
        print("Errore durante il login. Stato HTTP: ${response.statusCode}");
        return false;
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        print("Errore dal server durante il login: ${dioError.response?.data}");
      } else {
        print("Errore di rete durante il login: ${dioError.message}");
      }
    } catch (e) {
      print("Errore sconosciuto durante il login: $e");
    }
    return false;
  }

  // Metodo per ottenere il ruolo dell'utente dal token salvato
  static Future<String?> getUserRole() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("role");
    } catch (e) {
      print("Errore durante il recupero del ruolo: $e");
      return null;
    }
  }

  // Metodo per effettuare il logout
  static Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      await prefs.remove("role");
      print("Logout effettuato con successo.");
    } catch (e) {
      print("Errore durante il logout: $e");
    }
  }
}
