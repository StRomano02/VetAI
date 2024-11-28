import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.39:8000/api/users',
      connectTimeout: Duration(milliseconds: 15000),
      receiveTimeout: Duration(milliseconds: 15000),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  // Metodo POST
  static Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      if (token != null) {
        _dio.options.headers["Authorization"] = "Token $token";
        print("Token trovato e aggiunto all'header: $token");
      } else {
        print("Nessun token trovato nelle SharedPreferences.");
      }

      print("Eseguendo POST a $path con dati: $data");
      return await _dio.post(path, data: data);
    } catch (e) {
      print("Errore durante la richiesta POST: $e");
      rethrow;
    }
  }
}
