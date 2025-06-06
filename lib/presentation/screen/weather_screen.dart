import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import '../viewmodel/weather_viewmodel.dart';
import '../../domain/entity/weather_entity.dart';
import '../../domain/usecase/get_weather_usecase.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  late final WeatherViewModel _viewModel;

  WeatherScreen({super.key}) {
    final useCase = GetWeatherUseCase();
    _viewModel = WeatherViewModel(useCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌤 Погода'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Введите город',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.location_city),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final city = _controller.text;
                if (city.isEmpty) {
                  _showErrorDialog(context, 'Введите название города');
                  return;
                }

                // Показываем прогресс
                _showLoadingDialog(context);

                final weather = await _viewModel.getWeather(city);

                // Закрываем прогресс
                Navigator.of(context).pop();

                if (weather != null) {
                  _showWeatherDialog(context, weather);
                } else {
                  _showErrorDialog(context, 'Не удалось загрузить данные о погоде.');
                }
              },
              icon: const Icon(Icons.cloud),
              label: const Text('Показать погоду'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: SizedBox(
          height: 70,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void _showWeatherDialog(BuildContext context, WeatherEntity weather) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            weather.cityName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        content: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thermostat, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      '${weather.temp} °C',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Влажность: ${weather.humidity}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Закрыть'),
          )
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}