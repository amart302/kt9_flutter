import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherApi {
  final String apiKey = 'a5bb377d6ae8c8241abb15513d1ba772';

  Future<WeatherModel> getWeather(String city) async {
    final url = 'https://api.weatherstack.com/current?access_key=$apiKey&query=$city';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherModel(
        cityName: json['location']['name'],
        temp: json['current']['temperature'].toDouble(),
        humidity: json['current']['humidity'],
      );
    } else {
      throw Exception('Failed to load weather');
    }
  }
}