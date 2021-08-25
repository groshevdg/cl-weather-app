import 'package:cl_weather_app/weather/models/daily_weather.dart';
import 'package:cl_weather_app/weather/models/primary_weather_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable(createToJson: false)
class WeatherResponse extends Equatable {
  const WeatherResponse({required this.current, required this.daily});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  final PrimaryWeatherInfo current;
  final List<DailyWeather> daily;

  @override
  List<Object?> get props => [current, daily];
}
