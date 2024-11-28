import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8000/api", // Cambia con il tuo URL
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 5000),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  // Metodo POST
  static Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      // Aggiungi token di autenticazione se disponibile
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      if (token != null) {
        _dio.options.headers["Authorization"] = "Token $token";
      }

      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow; // Propaga l'errore per essere gestito a livello superiore
    }
  }
}
