import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/weather/models/weather_response.dart';
import 'package:dio/dio.dart';

class WeatherRepository {
  WeatherRepository(this._dio);

  final Dio _dio;

  Future<WeatherResponse> getWeatherInfoByPosition(
    String latitude,
    String longitude,
  ) async {
    final apiKey = Environment<Config>.instance().config.weatherApiKey;
    final response = await _dio.get<Map<String, dynamic>>(
      Api.weatherInfo(latitude, longitude, apiKey),
    );
    return WeatherResponse.fromJson(response.data!);
  }
}
