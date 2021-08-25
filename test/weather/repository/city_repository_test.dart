import 'package:cl_weather_app/common/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'city_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio dio;

  final response = Response(
    requestOptions: RequestOptions(path: Api.cityName('10.0', '10.0')),
    data: <String, dynamic>{
      'addresses': [
        <String, dynamic>{
          'address': <String, dynamic>{'municipality': 'cityName'}
        }
      ]
    },
  );

  final notValidResponse = Response(
    requestOptions: RequestOptions(path: Api.cityName('10.0', '10.0')),
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
    });

    test('Check successful response', () {
      when(dio.get<Map<String, dynamic>>(Api.cityName('10.0', '10.0')))
          .thenAnswer((_) async => response);

      expect(
        response.data?['addresses'][0]['address']['municipality'],
        'cityName',
      );
    });

    test("Check city didn't found", () {
      when(dio.get<Map<String, dynamic>>(Api.cityName('10.0', '10.0')))
          .thenAnswer((_) async => notValidResponse);

      expect(
        notValidResponse.data?['addresses'][0]['address']['municipality'],
        null,
      );
    });
  });
}
