import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_temperature.g.dart';

@JsonSerializable(createToJson: false)
class DailyTemperature extends Equatable {
  const DailyTemperature({required this.max, required this.min});

  factory DailyTemperature.fromJson(Map<String, dynamic> json) =>
      _$DailyTemperatureFromJson(json);

  final double max;
  final double min;

  @override
  List<Object?> get props => [max, min];
}
