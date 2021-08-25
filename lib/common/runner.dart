import 'dart:async';

import 'package:cl_weather_app/app.dart';
import 'package:cl_weather_app/common/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector().configure();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  _initLogger();
  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
    () async => runApp(const App()),
    (object, stackTrace) {},
  );
}

void _initLogger() {}
