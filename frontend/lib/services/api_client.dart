import 'package:dio/dio.dart';

const String baseUrl = "http://127.0.0.1:8000/api";

class ApiClient {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 5000), // Timeout connessione
      receiveTimeout: Duration(milliseconds: 3000), // Timeout risposta
    ),
  );

  static Future<Response> post(String path, Map<String, dynamic> data) async {
    return await dio.post(path, data: data);
  }

  static Future<Response> get(String path) async {
    return await dio.get(path);
  }
}
