import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';

class AuthService {
  static Future<bool> login(String username, String password) async {
    try {
      Response response = await ApiClient.post("/users/login/", {
        "username": username,
        "password": password,
      });

      if (response.statusCode == 200) {
        // Salva il token e il ruolo nelle SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data['token']);
        await prefs.setString("role", response.data['user']['role']);
        return true;
      }
    } catch (e) {
      print("Errore durante il login: $e");
    }
    return false;
  }
}
