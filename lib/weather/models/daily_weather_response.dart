import 'package:cl_weather_app/weather/models/daily_temperature_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_weather_response.g.dart';

@JsonSerializable(createToJson: false)
class DailyWeatherResponse extends Equatable {
  const DailyWeatherResponse({required this.temp});

  factory DailyWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherResponseFromJson(json);

  final DailyTemperatureResponse temp;

  @override
  List<Object?> get props => [temp];
}
