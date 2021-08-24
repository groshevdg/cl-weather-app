import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/routes_factory.dart';
import 'package:cl_weather_app/common/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  DebugOptions get _debug => Environment<Config>.instance().config.debugOptions;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: _debug.showPerformanceOverlay,
      debugShowMaterialGrid: _debug.debugShowMaterialGrid,
      checkerboardRasterCacheImages: _debug.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _debug.checkerboardOffscreenLayers,
      showSemanticsDebugger: _debug.showSemanticsDebugger,
      debugShowCheckedModeBanner: _debug.debugShowCheckedModeBanner,
      initialRoute: RoutesFactory.initialRoute,
      onGenerateRoute: RoutesFactory().getGeneratedRoutes,
      title: 'Weather App',
      theme: lightTheme,
      builder: (context, child) => BlocProvider(
        create: (context) => ErrorHandlerBloc(
          logger: Environment<Config>.instance().config.logger,
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        ),
      ),
    );
  }
}
