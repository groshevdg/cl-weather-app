import 'package:cl_weather_app/weather/models/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addresses.g.dart';

@JsonSerializable(createToJson: false)
class Addresses {
  Addresses({required this.address});

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);

  final Address address;
}
