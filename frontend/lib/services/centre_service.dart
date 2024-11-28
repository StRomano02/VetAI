import 'package:dio/dio.dart';

class CentreService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/'));

  // Ottieni tutti i centri
  Future<List<dynamic>> fetchCentres() async {
    try {
      final response = await _dio.get('centers/');
      return response.data;
    } catch (e) {
      throw Exception('Errore durante il recupero dei centri: $e');
    }
  }

  // Crea un nuovo centro
  Future<void> createCentre(Map<String, dynamic> centreData) async {
    try {
      await _dio.post('centers/', data: centreData);
    } catch (e) {
      throw Exception('Errore durante la creazione del centro: $e');
    }
  }
}
