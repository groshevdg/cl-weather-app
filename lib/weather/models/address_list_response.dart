import 'package:cl_weather_app/weather/models/address_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_list_response.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class AddressListResponse {
  AddressListResponse({required this.address});

  factory AddressListResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressListResponseFromJson(json);

  final AddressResponse? address;
}
