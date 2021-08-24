import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/bloc/weather_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required ErrorHandlerBloc errorHandlerBloc,
    required WeatherRepository weatherRepository,
  })  : _errorHandlerBloc = errorHandlerBloc,
        _weatherRepository = weatherRepository,
        super(const WeatherState.initial());

  final ErrorHandlerBloc _errorHandlerBloc;
  final WeatherRepository _weatherRepository;

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {}
}
