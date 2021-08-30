import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/weather/models/city_response.dart';
import 'package:dio/dio.dart';

class CityRepository {
  CityRepository(this._dio);

  final Dio _dio;

  Future<String?> getCityNameByPosition(
    String latitude,
    String longitude,
  ) async {
    final apiKey = Environment<Config>.instance().config.cityApiKey;
    final response = await _dio.get<Map<String, dynamic>>(
      Api.cityName(latitude, longitude, apiKey),
    );

    final cityResponse = CityResponse.fromJson(response.data!);
    return cityResponse.addresses[0].address.municipality;
  }
}
