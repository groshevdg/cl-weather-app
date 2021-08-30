import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/di/injector.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/ui/themes.dart';
import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/weather_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  DebugOptions get _debug => Environment<Config>.instance().config.debugOptions;

  Widget _home() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ErrorHandlerBloc(
              logger: Environment<Config>.instance().config.logger,
            ),
          ),
          BlocProvider(
            create: (context) => WeatherBloc(
                errorHandlerBloc: context.read<ErrorHandlerBloc>(),
                weatherRepository: getIt<WeatherRepository>(),
                locationRepository: getIt<LocationRepository>(),
                cityRepository: getIt<CityRepository>())
              ..add(WeatherInitialed()),
          ),
        ],
        child: const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: WeatherPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: _debug.showPerformanceOverlay,
      debugShowMaterialGrid: _debug.debugShowMaterialGrid,
      checkerboardRasterCacheImages: _debug.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _debug.checkerboardOffscreenLayers,
      showSemanticsDebugger: _debug.showSemanticsDebugger,
      debugShowCheckedModeBanner: _debug.debugShowCheckedModeBanner,
      home: _home(),
      title: 'Weather App',
      theme: lightTheme,
    );
  }
}
