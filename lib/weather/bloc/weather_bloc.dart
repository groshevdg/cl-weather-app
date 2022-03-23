import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/weather_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:cl_weather_app/weather/models/permission_exception.dart';
import 'package:cl_weather_app/weather/models/weather_info_ui.dart';
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
        super(const WeatherState.initial()) {
    on<WeatherInitialed>(_onWeatherInitialed);
  }

  final ErrorHandlerBloc _errorHandlerBloc;
  final WeatherRepository _weatherRepository;
  final LocationRepository _locationRepository;
  final CityRepository _cityRepository;

  Future<void> _onWeatherInitialed(WeatherInitialed event, Emitter emit) async {
    try {
      final position = await _locationRepository.fetchWithAskPermission();
      final city = await _cityRepository.getCityNameByPosition(position);

      final weather = await _weatherRepository.getWeatherInfoByPosition(
        position,
      );

      emit(WeatherState.loaded(
        weatherInfo: WeatherInfoUI.fromResponse(city, weather),
      ));
    } on Exception catch (e, s) {
      if (e is PermissionException) {
        emit(const WeatherState.locationDisabled());
      } else {
        _errorHandlerBloc.add(HandleErrorEvent(e, s));
        emit(const WeatherState.error());
      }
    }
  }
}
