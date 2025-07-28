import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/health_tips_model.dart';

class HealthTipsService {
  Future<List<HealthArticle>> fetchHealthArticles() async {
    final url = Uri.parse('https://health.gov/myhealthfinder/api/v3/topicsearch.json?lang=en');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List articles = json.decode(response.body)['Result']['Resources']['Resource'];
      return articles.map((json) => HealthArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load health articles');
    }
  }
}
