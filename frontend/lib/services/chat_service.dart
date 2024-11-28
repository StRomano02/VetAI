import 'package:dio/dio.dart';

class ChatService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/'));

  // Ottieni tutte le chat
  Future<List<dynamic>> fetchChats() async {
    try {
      final response = await _dio.get('chats/');
      return response.data; // Ritorna la lista di chat
    } catch (e) {
      throw Exception('Errore durante il recupero delle chat: $e');
    }
  }

  // Ottieni i messaggi di una chat specifica
  Future<List<dynamic>> fetchMessages(String chatId) async {
    try {
      final response = await _dio.get('messages/', queryParameters: {
        'chat_id': chatId,
      });
      return response.data; // Ritorna i messaggi della chat
    } catch (e) {
      throw Exception('Errore durante il recupero dei messaggi: $e');
    }
  }

  // Invia un messaggio
  Future<void> sendMessage(String chatId, String sender, String text) async {
    try {
      await _dio.post('messages/', data: {
        'chat': chatId,
        'sender': sender,
        'text': text,
      });
    } catch (e) {
      throw Exception('Errore durante l\'invio del messaggio: $e');
    }
  }
}
