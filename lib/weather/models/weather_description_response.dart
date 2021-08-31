import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_description_response.g.dart';

@JsonSerializable(createToJson: false)
class WeatherDescriptionResponse extends Equatable {
  const WeatherDescriptionResponse({required this.description});

  factory WeatherDescriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionResponseFromJson(json);

  final String description;

  @override
  List<Object?> get props => [description];
}
