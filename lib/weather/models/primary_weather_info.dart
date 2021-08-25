import 'package:cl_weather_app/weather/models/weather_description.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'primary_weather_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PrimaryWeatherInfo extends Equatable {
  const PrimaryWeatherInfo({
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.pressure,
    required this.weatherDescription,
  });

  factory PrimaryWeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$PrimaryWeatherInfoFromJson(json);

  @JsonKey(fromJson: _formatSecondsToTimeOfDay)
  final TimeOfDay sunrise;

  @JsonKey(fromJson: _formatSecondsToTimeOfDay)
  final TimeOfDay sunset;

  @JsonKey(name: 'weather')
  final List<WeatherDescription> weatherDescription;

  final double temp;
  final double humidity;
  final int visibility;
  final int pressure;
  final double windSpeed;

  static TimeOfDay _formatSecondsToTimeOfDay(int seconds) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(seconds * 1000).toLocal();
    return TimeOfDay.fromDateTime(dateTime);
  }

  @override
  List<Object?> get props => [
        sunrise,
        sunset,
        temp,
        humidity,
        visibility,
        pressure,
        windSpeed,
        weatherDescription,
      ];
}
