import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_description.g.dart';

@JsonSerializable(createToJson: false)
class WeatherDescription extends Equatable {
  const WeatherDescription({required this.description});

  factory WeatherDescription.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionFromJson(json);

  final String description;

  @override
  List<Object?> get props => [description];
}
