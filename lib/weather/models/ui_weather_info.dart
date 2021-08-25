import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UiWeatherInfo extends Equatable {
  const UiWeatherInfo({
    this.city = '',
    this.currentTemp = '0°',
    this.pressure = '0',
    this.humidity = '0%',
    this.maxTemp = '0°',
    this.minTemp = '0°',
    this.visibility = '0 km',
    this.wind = '0 m/s',
    this.weatherDescription = 'Sunny',
    this.sunrise = const TimeOfDay(hour: 0, minute: 0),
    this.sunset = const TimeOfDay(hour: 0, minute: 0),
  });

  final String city;
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
        weatherDescription,
        sunrise,
        sunset,
      ];
}
