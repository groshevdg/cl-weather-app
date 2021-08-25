import 'package:cl_weather_app/common/env/build_types.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/logger/production_logger.dart';
import 'package:cl_weather_app/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.release,
    config: Config(
      logger: ProductionLogger(),
      debugOptions: DebugOptions(),
      weatherApiKey:
          'Generate your own api key here https://openweathermap.org/api/one-call-api',
      cityApiKey:
          'Generate your own api key here https://developer.tomtom.com/',
    ),
  );

  run();
}
