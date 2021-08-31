import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/weather/models/city_response.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class CityRepository {
  CityRepository(this._dio);

  final Dio _dio;

  Future<String?> getCityNameByPosition(Position position) async {
    final response = await _dio.get<Map<String, dynamic>>(
      Api.cityName(
        position.latitude.toString(),
        position.longitude.toString(),
        Environment<Config>.instance().config.cityApiKey,
      ),
    );

    final cityResponse = CityResponse.fromJson(response.data!);

    if (cityResponse.addresses.isNotEmpty) {
      return cityResponse.addresses.first.address?.municipality;
    } else {
      return null;
    }
  }
}
