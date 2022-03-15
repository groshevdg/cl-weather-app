import 'package:cl_weather_app/weather/models/weather_info_ui.dart';
import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  const WeatherState._({
    required this.status,
    this.weatherInfo = const WeatherInfoUI.defaults(),
  });

  const WeatherState.initial() : this._(status: WeatherStatus.initial);

  const WeatherState.error() : this._(status: WeatherStatus.error);

  const WeatherState.locationDisabled()
      : this._(status: WeatherStatus.locationDisabled);

  const WeatherState.loaded({required WeatherInfoUI weatherInfo})
      : this._(status: WeatherStatus.loaded, weatherInfo: weatherInfo);

  final WeatherStatus status;
  final WeatherInfoUI weatherInfo;

  @override
  List<Object?> get props => [status, weatherInfo];
}

enum WeatherStatus { initial, loaded, locationDisabled, error }
