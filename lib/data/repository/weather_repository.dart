import '../datasource/weather_api.dart';
import '../model/weather_model.dart';

class WeatherRepository {
  final WeatherApi _api = WeatherApi();

  Future<WeatherModel> fetchWeather(String city) async {
    return await _api.getWeather(city);
  }
}