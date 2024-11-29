import 'package:dio/dio.dart';

class AnimalService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/'));

  // Ottieni tutti gli animali
  Future<List<dynamic>> fetchAnimals() async {
    try {
      final response = await _dio.get('animals/');
      return response.data;
    } catch (e) {
      throw Exception('Errore durante il recupero degli animali: $e');
    }
  }

  // Crea un nuovo animale
  Future<void> createAnimal(Map<String, dynamic> animalData) async {
    try {
      await _dio.post('animals/', data: animalData);
    } catch (e) {
      throw Exception('Errore durante la creazione dell\'animale: $e');
    }
  }

// Aggiorna un animale
  Future<void> updateAnimal(String id, Map<String, dynamic> animalData) async {
    try {
      await _dio.put('animals/$id/', data: animalData);
    } catch (e) {
      throw Exception('Errore durante l\'aggiornamento dell\'animale: $e');
    }
  }

// Elimina un animale
  Future<void> deleteAnimal(String id) async {
    try {
      await _dio.delete('animals/$id/');
    } catch (e) {
      throw Exception('Errore durante l\'eliminazione dell\'animale: $e');
    }
  }
}
