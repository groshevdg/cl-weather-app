import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  void configure() {
    final dio = Dio();
    getIt
      ..registerSingleton<WeatherRepository>(WeatherRepository(dio))
      ..registerSingleton<LocationRepository>(LocationRepository())
      ..registerSingleton<CityRepository>(CityRepository(dio));
  }
}
