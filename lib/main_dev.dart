import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cl_weather_app/common/debug_bloc_observer.dart';
import 'package:cl_weather_app/common/env/build_types.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/logger/dev_logger.dart';
import 'package:cl_weather_app/common/runner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DebugBlocObserver();

  Environment.init(
    buildType: BuildType.dev,
    config: Config(
      logger: DevLogger(),
      title: 'ENV Flutter application template with Bloc state manager',
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
