import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(createToJson: false)
class Address {
  Address({required this.municipality});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  final String? municipality;
}
