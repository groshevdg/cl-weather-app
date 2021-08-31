import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/weather_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:cl_weather_app/weather/models/permission_exception.dart';
import 'package:cl_weather_app/weather/models/weather_info_ui.dart';
import 'package:cl_weather_app/weather/models/weather_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required ErrorHandlerBloc errorHandlerBloc,
    required WeatherRepository weatherRepository,
    required LocationRepository locationRepository,
    required CityRepository cityRepository,
  })  : _errorHandlerBloc = errorHandlerBloc,
        _weatherRepository = weatherRepository,
        _locationRepository = locationRepository,
        _cityRepository = cityRepository,
        super(const WeatherState.initial());

  final ErrorHandlerBloc _errorHandlerBloc;
  final WeatherRepository _weatherRepository;
  final LocationRepository _locationRepository;
  final CityRepository _cityRepository;

  WeatherInfoUI _getUiWeatherInfo(String? cityName, WeatherResponse weather) {
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

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherInitialed) {
      yield* _mapWeatherInitialed(event);
    }
  }

  Stream<WeatherState> _mapWeatherInitialed(WeatherInitialed event) async* {
    try {
      final position = await _locationRepository.fetchWithAskPermission();
      final city = await _cityRepository.getCityNameByPosition(position);

      final weather = await _weatherRepository.getWeatherInfoByPosition(
        position,
      );

      yield WeatherState.loaded(
        weatherInfo: _getUiWeatherInfo(city, weather),
      );
    } on Exception catch (e, s) {
      if (e is PermissionException) {
        yield const WeatherState.locationDisabled();
      } else {
        _errorHandlerBloc.add(HandleErrorEvent(e, s));
        yield const WeatherState.error();
      }
    }
  }
}
