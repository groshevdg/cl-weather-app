import 'package:cl_weather_app/weather/bloc/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  void configure() {
    getIt
      ..registerSingleton<WeatherRepository>(WeatherRepository())
      ..registerSingleton<LocationRepository>(LocationRepository());
  }
}
