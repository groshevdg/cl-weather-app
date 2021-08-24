import 'package:equatable/equatable.dart';

enum WeatherStatus { initial }

class WeatherState extends Equatable {
  const WeatherState._({required this.status});

  const WeatherState.initial() : this._(status: WeatherStatus.initial);

  final WeatherStatus status;

  @override
  List<Object?> get props => [status];
}
