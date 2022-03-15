import 'package:cl_weather_app/common/debug_bloc_observer.dart';
import 'package:cl_weather_app/common/env/build_types.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/logger/dev_logger.dart';
import 'package:cl_weather_app/common/runner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => Environment.init(
      buildType: BuildType.dev,
      config: Config(
        logger: DevLogger(),
        debugOptions: DebugOptions(),
        weatherApiKey:
            'Generate your own api key here https://openweathermap.org/api/one-call-api',
        cityApiKey:
            'Generate your own api key here https://developer.tomtom.com/',
      ),
    ),
    blocObserver: DebugBlocObserver(),
  );

  run();
}
