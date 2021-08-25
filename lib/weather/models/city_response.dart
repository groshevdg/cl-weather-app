import 'package:cl_weather_app/weather/models/addresses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_response.g.dart';

@JsonSerializable(createToJson: false)
class CityResponse {
  CityResponse({required this.addresses});

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  final List<Addresses> addresses;
}
