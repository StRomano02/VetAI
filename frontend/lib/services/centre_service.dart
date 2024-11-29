import 'package:dio/dio.dart';

class CentreService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/'));

  // Ottieni i dati di un centro
  Future<Map<String, dynamic>> fetchCentre(String id) async {
    try {
      final response = await _dio.get('centres/$id/');
      return response.data;
    } catch (e) {
      throw Exception('Errore durante il recupero del centro: $e');
    }
  }

  // Crea un nuovo centro
  Future<void> createCentre(Map<String, dynamic> centreData) async {
    try {
      await _dio.post('centres/', data: centreData);
    } catch (e) {
      throw Exception('Errore durante la creazione del centro: $e');
    }
  }

  // Modifica un centro esistente
  Future<void> updateCentre(String id, Map<String, dynamic> centreData) async {
    try {
      await _dio.put('centres/$id/', data: centreData);
    } catch (e) {
      throw Exception('Errore durante l\'aggiornamento del centro: $e');
    }
  }

  // Elimina un centro
  Future<void> deleteCentre(String id) async {
    try {
      await _dio.delete('centres/$id/');
    } catch (e) {
      throw Exception('Errore durante l\'eliminazione del centro: $e');
    }
  }
}
