import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cl_weather_app/app.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

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
