import 'package:cl_weather_app/weather/models/weather_description_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'primary_weather_info_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PrimaryWeatherInfoResponse extends Equatable {
  const PrimaryWeatherInfoResponse({
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.pressure,
    required this.weatherDescription,
  });

  factory PrimaryWeatherInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PrimaryWeatherInfoResponseFromJson(json);

  @JsonKey(fromJson: _formatSecondsToTimeOfDay)
  final TimeOfDay sunrise;

  @JsonKey(fromJson: _formatSecondsToTimeOfDay)
  final TimeOfDay sunset;

  @JsonKey(name: 'weather')
  final List<WeatherDescriptionResponse> weatherDescription;

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
