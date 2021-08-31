import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_temperature_response.g.dart';

@JsonSerializable(createToJson: false)
class DailyTemperatureResponse extends Equatable {
  const DailyTemperatureResponse({required this.max, required this.min});

  factory DailyTemperatureResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyTemperatureResponseFromJson(json);

  final double max;
  final double min;

  @override
  List<Object?> get props => [max, min];
}
