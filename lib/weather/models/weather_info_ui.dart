import 'package:cl_weather_app/weather/models/weather_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WeatherInfoUI extends Equatable {
  const WeatherInfoUI({
    required this.city,
    required this.currentTemp,
    required this.pressure,
    required this.humidity,
    required this.maxTemp,
    required this.minTemp,
    required this.visibility,
    required this.wind,
    required this.weatherDescription,
    required this.sunrise,
    required this.sunset,
  });

  const WeatherInfoUI.defaults({
    this.city = '',
    this.currentTemp = '0',
    this.pressure = '0',
    this.humidity = '0',
    this.maxTemp = '0',
    this.minTemp = '0',
    this.visibility = '0',
    this.wind = '0',
    this.weatherDescription = 'Sunny',
    this.sunrise = const TimeOfDay(hour: 0, minute: 0),
    this.sunset = const TimeOfDay(hour: 0, minute: 0),
  });

  factory WeatherInfoUI.fromResponse(
    String? cityName,
    WeatherResponse weather,
  ) {
    return WeatherInfoUI(
      city: cityName,
      currentTemp: weather.current.temp.round().toString(),
      maxTemp: weather.daily.first.temp.max.round().toString(),
      minTemp: weather.daily.first.temp.min.round().toString(),
      humidity: weather.current.humidity.toString(),
      pressure: weather.current.pressure.toString(),
      visibility: (weather.current.visibility / 1000.0).toString(),
      wind: weather.current.windSpeed.toString(),
      weatherDescription: weather.current.weatherDescription.first.description,
      sunrise: weather.current.sunrise,
      sunset: weather.current.sunset,
    );
  }

  final String? city;
  final String currentTemp;
  final String maxTemp;
  final String minTemp;
  final String humidity;
  final String visibility;
  final String pressure;
  final String wind;
  final String weatherDescription;
  final TimeOfDay sunrise;
  final TimeOfDay sunset;

  @override
  List<Object?> get props => [
        city,
        currentTemp,
        maxTemp,
        minTemp,
        humidity,
        visibility,
        pressure,
        wind,
        weatherDescription,
        sunrise,
        sunset,
      ];
}
