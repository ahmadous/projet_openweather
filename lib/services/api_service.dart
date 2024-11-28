// services/weather_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiService {
  final String baseUrl;
  final String apiKey;

  WeatherApiService({required this.baseUrl, required this.apiKey});

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response =
        await http.get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
