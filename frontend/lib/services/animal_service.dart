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
}
