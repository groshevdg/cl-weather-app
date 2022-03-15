import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/weather/models/weather_response.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository {
  const WeatherRepository(this._dio);

  final Dio _dio;

  Future<WeatherResponse> getWeatherInfoByPosition(Position position) async {
    final response = await _dio.get<Map<String, dynamic>>(
      Api.weatherInfo(
        position.latitude.toString(),
        position.longitude.toString(),
        Environment<Config>.instance().config.weatherApiKey,
      ),
    );

    return WeatherResponse.fromJson(response.data!);
  }
}
