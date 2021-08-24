import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_event.dart';
import 'package:cl_weather_app/weather/bloc/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/bloc/weather_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required ErrorHandlerBloc errorHandlerBloc,
    required WeatherRepository weatherRepository,
    required LocationRepository locationRepository,
  })  : _errorHandlerBloc = errorHandlerBloc,
        _weatherRepository = weatherRepository,
        _locationRepository = locationRepository,
        super(const WeatherState.initial());

  final ErrorHandlerBloc _errorHandlerBloc;
  final WeatherRepository _weatherRepository;
  final LocationRepository _locationRepository;

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherInitialed) {
      _mapWeatherInitialed(event);
    }
  }

  Stream<WeatherState> _mapWeatherInitialed(WeatherInitialed event) async* {
    try {
      final location = _locationRepository.fetchWithAskPermission();
    } on Exception catch (e, s) {
      _errorHandlerBloc.add(HandleErrorEvent(e, s));
    }
  }
}
