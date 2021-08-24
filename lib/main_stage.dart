import 'package:cl_weather_app/common/env/build_types.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/logger/dev_logger.dart';
import 'package:cl_weather_app/common/runner.dart';

void main() {
  Environment.init(
    buildType: BuildType.stage,
    config: Config(
      logger: DevLogger(),
      title: 'ENV Flutter application template with Bloc state manager',
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
