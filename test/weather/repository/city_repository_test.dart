import 'package:cl_weather_app/common/api.dart';
import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'city_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio dio;
  late CityRepository cityRepository;

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
      cityRepository = CityRepository(dio);
    });

    test('Check successful response', () async {
      when(dio.get<Map<String, dynamic>>(Api.cityName('10.0', '10.0', '')))
          .thenAnswer((_) async => response);

      final city = await cityRepository.getCityNameByPosition('10.0', '10.0');

      expect(city, 'cityName');
    });

    test("Check city didn't found", () async {
      when(dio.get<Map<String, dynamic>>(Api.cityName('10.0', '10.0', '')))
          .thenAnswer((_) async => notValidResponse);

      final city = await cityRepository.getCityNameByPosition('10.0', '10.0');

      expect(city, null);
    });
  });
}