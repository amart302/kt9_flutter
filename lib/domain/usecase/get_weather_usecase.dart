import '../../data/repository/weather_repository.dart';
import '../../domain/entity/weather_entity.dart';

class GetWeatherUseCase {
  final WeatherRepository _repository = WeatherRepository();

  Future<WeatherEntity> execute(String city) async {
    final model = await _repository.fetchWeather(city);
    return WeatherEntity(
      cityName: model.cityName,
      temp: model.temp,
      humidity: model.humidity,
    );
  }
}