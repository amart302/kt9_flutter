import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final String cityName;
  final double temp;
  final int humidity;

  WeatherModel({required this.cityName, required this.temp, required this.humidity});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}