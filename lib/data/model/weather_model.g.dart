// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  cityName: json['cityName'] as String,
  temp: (json['temp'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temp': instance.temp,
      'humidity': instance.humidity,
    };
