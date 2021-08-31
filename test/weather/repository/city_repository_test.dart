import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/common/env/build_types.dart';
import 'package:cl_weather_app/common/env/config.dart';
import 'package:cl_weather_app/common/env/debug_options.dart';
import 'package:cl_weather_app/common/env/environment.dart';
import 'package:cl_weather_app/common/logger/logger.dart';
import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'city_repository_test.mocks.dart';

@GenerateMocks([Dio, Logger, DebugOptions])
void main() {
  late MockDio dio;
  late CityRepository cityRepository;

  final position = Position(
    longitude: 10.00,
    latitude: 10.00,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  final response = Response(
    requestOptions: RequestOptions(path: Api.cityName('10.0', '10.0', '')),
    data: <String, dynamic>{
      'addresses': [
        <String, dynamic>{
          'address': <String, dynamic>{'municipality': 'cityName'}
        }
      ]
    },
  );

  final notValidResponse = Response(
    requestOptions: RequestOptions(path: Api.cityName('10.0', '10.0', '')),
    data: <String, dynamic>{
      'addresses': [
        <String, dynamic>{
          'address': <String, dynamic>{'': ''}
        }
      ]
    },
  );

  group('TestCityRepository', () {
    setUp(() {
      dio = MockDio();
      Environment.init(
        buildType: BuildType.dev,
        config: Config(
          logger: MockLogger(),
          debugOptions: MockDebugOptions(),
          cityApiKey: '',
          weatherApiKey: '',
        ),
      );
      cityRepository = CityRepository(dio);
    });

    test('Check successful response', () async {
      when(dio.get<Map<String, dynamic>>(Api.cityName('10.0', '10.0', '')))
          .thenAnswer((_) async => response);

      final city = await cityRepository.getCityNameByPosition(position);

      expect(city, 'cityName');
    });

    test("Check city didn't found", () async {
      when(dio.get<Map<String, dynamic>>(Api.cityName('10.0', '10.0', '')))
          .thenAnswer((_) async => notValidResponse);

      final city = await cityRepository.getCityNameByPosition(position);

      expect(city, null);
    });
  });
}
