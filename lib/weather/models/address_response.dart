import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable(createToJson: false, includeIfNull: true)
class AddressResponse {
  AddressResponse({required this.municipality});

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  final String? municipality;
}
