import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/common/di/injector.dart';
import 'package:cl_weather_app/common/routes.dart';
import 'package:cl_weather_app/weather/bloc/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/bloc/weather_repository.dart';
import 'package:cl_weather_app/weather/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesFactory {
  static String get initialRoute => Routes.weather;

  Map<String, Widget Function(BuildContext)> get _routes => {
        Routes.weather: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => WeatherBloc(
                  errorHandlerBloc: context.read<ErrorHandlerBloc>(),
                  weatherRepository: getIt<WeatherRepository>(),
                  locationRepository: getIt<LocationRepository>(),
                )..add(WeatherInitialed()),
              ),
            ],
            child: const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: WeatherPage(),
            ),
          );
        },
      };

  Route<dynamic> getGeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (context) => _routes[settings.name]!(context),
        );
    }
  }
}
