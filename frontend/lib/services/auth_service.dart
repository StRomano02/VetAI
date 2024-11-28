import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8000/api/users', // Cambia con il tuo URL
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 5000),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Metodo per la registrazione
  static Future<void> signUp(String name, String surname, String email,
      String password, String role) async {
    try {
      final fullName = '$name $surname';

      final response = await _dio.post('/register/', data: {
        'name': fullName,
        'email': email,
        'password': password,
        'role': role,
      });

      if (response.statusCode != 201) {
        throw Exception('Errore durante la registrazione');
      }
    } on DioError catch (dioError) {
      throw Exception(dioError.response?.data['detail'] ?? 'Errore di rete');
    }
  }

  static Future<bool> login(String username, String password) async {
    try {
      // Esegui la richiesta di login
      Response response = await ApiClient.post("/users/login/", {
        "username": username,
        "password": password,
      });

      // Se il server restituisce uno stato 200 (successo)
      if (response.statusCode == 200) {
        // Salva il token e il ruolo nelle SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data['token']);
        await prefs.setString("role", response.data['user']['role']);
        return true;
      } else {
        // Gestione degli errori specifici dello stato HTTP
        print("Errore: Stato HTTP ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      // Gestione specifica degli errori Dio
      if (dioError.response != null) {
        print("Errore dal server: ${dioError.response?.data}");
      } else {
        print("Errore di rete: ${dioError.message}");
      }
    } catch (e) {
      // Altri errori generici
      print("Errore sconosciuto durante il login: $e");
    }
    return false;
  }
}
