import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/common/env/build_types.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/logger/logger.dart';
import 'package:cl_weather_app/weather/bloc/repositories/weather_repository.dart';
import 'package:cl_weather_app/weather/models/daily_temperature.dart';
import 'package:cl_weather_app/weather/models/daily_weather.dart';
import 'package:cl_weather_app/weather/models/primary_weather_info.dart';
import 'package:cl_weather_app/weather/models/weather_description.dart';
import 'package:cl_weather_app/weather/models/weather_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([Dio, DebugOptions, Logger])
void main() {
  group('TestWeatherRepository', () {
    late MockDio dio;
    late WeatherRepository repository;

    final weather = WeatherResponse(
      current: PrimaryWeatherInfo(
        visibility: 10000,
        pressure: 1000,
        humidity: 10.0,
        temp: 25,
        windSpeed: 8,
        weatherDescription: const [
          WeatherDescription(description: 'description'),
        ],
        sunset: TimeOfDay.fromDateTime(DateTime.now()),
        sunrise: TimeOfDay.fromDateTime(DateTime.now()),
      ),
      daily: const [DailyWeather(temp: DailyTemperature(min: 10, max: 30))],
    );

    final weatherResponse = Response(
      requestOptions: RequestOptions(
        path: Api.weatherInfo('10.0', '10.0', ''),
      ),
      data: <String, dynamic>{
        'current': <String, dynamic>{
          'temp': 25,
          'wind_speed': 8,
          'humidity': 10.0,
          'pressure': 1000,
          'visibility': 10000,
          'weather': [
            <String, dynamic>{'description': 'description'}
          ],
          'sunrise': DateTime.now().millisecondsSinceEpoch ~/ 1000,
          'sunset': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        },
        'daily': [
          <String, dynamic>{
            'temp': <String, dynamic>{'max': 30, 'min': 10}
          }
        ],
      },
    );

    setUp(() {
      dio = MockDio();
      repository = WeatherRepository(dio);
      Environment.init(
        buildType: BuildType.dev,
        config: Config(
          logger: MockLogger(),
          debugOptions: MockDebugOptions(),
          cityApiKey: '',
          weatherApiKey: '',
        ),
      );
    });

    test('Check successful response', () async {
      when(dio.get<Map<String, dynamic>>(Api.weatherInfo('10.0', '10.0', '')))
          .thenAnswer((_) async => weatherResponse);

      final response =
          await repository.getWeatherInfoByPosition('10.0', '10.0');

      expect(response, equals(weather));
    });
  });
}
