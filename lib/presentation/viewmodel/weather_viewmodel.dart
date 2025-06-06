import 'package:elementary/elementary.dart';
import '../../domain/usecase/get_weather_usecase.dart';
import '../../domain/entity/weather_entity.dart';

class WeatherViewModel extends ElementaryModel {
  final GetWeatherUseCase _useCase;

  WeatherViewModel(this._useCase);

  Future<WeatherEntity?> getWeather(String city) async {
    try {
      return await _useCase.execute(city);
    } catch (e) {
      print("Error fetching weather: $e");
      return null;
    }
  }
}