import 'package:cl_weather_app/weather/models/daily_temperature.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_weather.g.dart';

@JsonSerializable(createToJson: false)
class DailyWeather extends Equatable {
  const DailyWeather({required this.temp});

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);

  final DailyTemperature temp;

  @override
  List<Object?> get props => [temp];
}
