import 'package:bloc_test/bloc_test.dart';
import 'package:cl_weather_app/common/bloc/error_handler_bloc/error_handler_bloc.dart';
import 'package:cl_weather_app/weather/bloc/repositories/city_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/location_repository.dart';
import 'package:cl_weather_app/weather/bloc/repositories/weather_repository.dart';
import 'package:cl_weather_app/weather/bloc/weather_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_event.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:cl_weather_app/weather/models/daily_temperature_response.dart';
import 'package:cl_weather_app/weather/models/daily_weather_response.dart';
import 'package:cl_weather_app/weather/models/permission_exception.dart';
import 'package:cl_weather_app/weather/models/primary_weather_info_response.dart';
import 'package:cl_weather_app/weather/models/weather_description_response.dart';
import 'package:cl_weather_app/weather/models/weather_info_ui.dart';
import 'package:cl_weather_app/weather/models/weather_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([
  ErrorHandlerBloc,
  LocationRepository,
  WeatherRepository,
  CityRepository,
])
void main() {
  group('WeatherBlocFlowTest', () {
    late MockErrorHandlerBloc errorHandlerBloc;
    late MockLocationRepository locationRepository;
    late MockWeatherRepository weatherRepository;
    late MockCityRepository cityRepository;
    late WeatherBloc bloc;

    const city = 'expectedCityName';

    final position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
    );

    const uiWeatherInfo = WeatherInfoUI(
      weatherDescription: 'cloud',
      humidity: '20.0',
      pressure: '1010',
      visibility: '10.0',
      maxTemp: '30',
      minTemp: '20',
      currentTemp: '25',
      city: city,
      wind: '8.0',
      sunrise: TimeOfDay(hour: 5, minute: 0),
      sunset: TimeOfDay(hour: 19, minute: 0),
    );

    const uiWeatherInfoUnknownCity = WeatherInfoUI(
      weatherDescription: 'cloud',
      humidity: '20.0',
      pressure: '1010',
      visibility: '10.0',
      maxTemp: '30',
      minTemp: '20',
      currentTemp: '25',
      city: null,
      wind: '8.0',
      sunrise: TimeOfDay(hour: 5, minute: 0),
      sunset: TimeOfDay(hour: 19, minute: 0),
    );

    const weather = WeatherResponse(
      current: PrimaryWeatherInfoResponse(
        sunrise: TimeOfDay(hour: 5, minute: 0),
        sunset: TimeOfDay(hour: 19, minute: 0),
        visibility: 10000,
        pressure: 1010,
        humidity: 20,
        temp: 25,
        windSpeed: 8,
        weatherDescription: <WeatherDescriptionResponse>[
          WeatherDescriptionResponse(description: 'cloud'),
        ],
      ),
      daily: <DailyWeatherResponse>[
        DailyWeatherResponse(temp: DailyTemperatureResponse(max: 30, min: 20)),
      ],
    );

    setUp(() {
      errorHandlerBloc = MockErrorHandlerBloc();
      locationRepository = MockLocationRepository();
      weatherRepository = MockWeatherRepository();
      cityRepository = MockCityRepository();
      bloc = WeatherBloc(
        errorHandlerBloc: errorHandlerBloc,
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
        cityRepository: cityRepository,
      );
    });

    blocTest<WeatherBloc, WeatherState>(
      'Check successful load weather info',
      build: () {
        when(locationRepository.fetchWithAskPermission())
            .thenAnswer((_) async => position);
        when(cityRepository.getCityNameByPosition(position))
            .thenAnswer((_) async => city);
        when(weatherRepository.getWeatherInfoByPosition(position))
            .thenAnswer((_) async => weather);
        return bloc;
      },
      act: (bloc) => bloc.add(const WeatherInitialed()),
      expect: () => <WeatherState>[
        const WeatherState.loaded(weatherInfo: uiWeatherInfo),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'Check user disabled position translation error',
      build: () {
        when(locationRepository.fetchWithAskPermission())
            .thenThrow(PermissionException());
        when(cityRepository.getCityNameByPosition(position))
            .thenAnswer((_) async => city);
        when(weatherRepository.getWeatherInfoByPosition(position))
            .thenAnswer((_) async => weather);
        return bloc;
      },
      act: (bloc) => bloc.add(const WeatherInitialed()),
      expect: () => <WeatherState>[const WeatherState.locationDisabled()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'Check loading data error',
      build: () {
        when(locationRepository.fetchWithAskPermission())
            .thenAnswer((_) async => position);
        when(cityRepository.getCityNameByPosition(position))
            .thenThrow(Exception());
        when(weatherRepository.getWeatherInfoByPosition(position))
            .thenAnswer((_) async => weather);
        return bloc;
      },
      act: (bloc) => bloc.add(const WeatherInitialed()),
      expect: () => <WeatherState>[const WeatherState.error()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'Check null city name',
      build: () {
        when(locationRepository.fetchWithAskPermission())
            .thenAnswer((_) async => position);
        when(cityRepository.getCityNameByPosition(position))
            .thenAnswer((_) async => null);
        when(weatherRepository.getWeatherInfoByPosition(position))
            .thenAnswer((_) async => weather);
        return bloc;
      },
      act: (bloc) => bloc.add(const WeatherInitialed()),
      expect: () => <WeatherState>[
        const WeatherState.loaded(weatherInfo: uiWeatherInfoUnknownCity),
      ],
    );
  });
}
