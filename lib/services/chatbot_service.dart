import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const String apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static final String apiToken = dotenv.env['OPENROUTER_API_KEY']!;

  Future<String> getChatbotResponse(String prompt) async {
    try {
      if (!dotenv.isInitialized || dotenv.env['OPENROUTER_API_KEY'] == null) {
        throw Exception('API key is missing! Check your .env file.');
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'deepseek/deepseek-chat',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 200,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]['message']['content']?.trim();
        if (content == null || content.isEmpty) {
          throw Exception('No valid response content from chatbot');
        }
        return content;
      } else {
        throw Exception('Failed to get response from chatbot (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to connect to chatbot service: $e');
    }
  }

  // Helper method to parse barcodes from chatbot response
  List<String> parseBarcodes(String response) {
    // Match 6-13 digit numbers (typical barcode length)
    final barcodeRegExp = RegExp(r'\b\d{6,13}\b');
    final barcodes = barcodeRegExp
        .allMatches(response)
        .map((match) => match.group(0)!)
        .toList()
        .toSet()
        .toList(); // Remove duplicates
    return barcodes;
  }
}