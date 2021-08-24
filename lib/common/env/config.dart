import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/logger/logger.dart';

class Config {
  Config({
    required this.logger,
    required this.title,
    required this.debugOptions,
  });

  final Logger logger;
  final String title;
  final DebugOptions debugOptions;
}
