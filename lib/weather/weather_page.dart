import 'package:cl_weather_app/common/app_assets.dart';
import 'package:cl_weather_app/common/ui/app_colors.dart';
import 'package:cl_weather_app/common/ui/app_text_styles.dart';
import 'package:cl_weather_app/weather/bloc/weather_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  void _blocListener(BuildContext context, WeatherState state) {
    if (state.status == WeatherStatus.locationDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enable location service to get weather info'),
        ),
      );
    } else if (state.status == WeatherStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error happened while loading data'),
        ),
      );
    }
  }

  Widget _additionalInfoWidget({
    required String asset,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(asset, width: 25, color: AppColors.iconOverlay),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.iconOverlay,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: AppColors.iconOverlay, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _mainInfoRowItem({required String title, required String value}) {
    return Column(
      children: [
        Text(title, style: AppTextStyles.regularTextStyle),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.regularTextStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: _blocListener,
          builder: (context, state) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  state.status == WeatherStatus.initial
                      ? Shimmer.fromColors(
                          baseColor: AppColors.containerBackground,
                          highlightColor: AppColors.iconOverlay,
                          child: Text(
                            'Searching...',
                            style: AppTextStyles.boldTextStyle,
                          ),
                        )
                      : Text(
                          state.weatherInfo.city ?? 'Unknown',
                          style: AppTextStyles.boldTextStyle,
                        ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.weatherInfo.currentTemp}°',
                    style: AppTextStyles.boldTextStyle.copyWith(fontSize: 80),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.weatherInfo.weatherDescription,
                    style: AppTextStyles.regularTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'H: ${state.weatherInfo.maxTemp}°',
                        style: AppTextStyles.regularTextStyle,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'M: ${state.weatherInfo.minTemp}°',
                        style: AppTextStyles.regularTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _mainInfoRowItem(
                        title: 'Humidity',
                        value: '${state.weatherInfo.humidity}%',
                      ),
                      Container(
                        width: 1.5,
                        color: AppColors.iconOverlay,
                        height: 40,
                      ),
                      _mainInfoRowItem(
                        title: 'Visibility',
                        value: '${state.weatherInfo.visibility} km',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.count(
                      childAspectRatio: 0.75,
                      crossAxisCount: 4,
                      children: [
                        _additionalInfoWidget(
                          asset: AppAssets.sunrise,
                          title: 'Sunrise',
                          value: state.weatherInfo.sunrise.format(context),
                        ),
                        _additionalInfoWidget(
                          asset: AppAssets.wind,
                          title: 'Wind',
                          value: '${state.weatherInfo.wind} m/s',
                        ),
                        _additionalInfoWidget(
                          asset: AppAssets.pressure,
                          title: 'Pressure',
                          value: state.weatherInfo.pressure,
                        ),
                        _additionalInfoWidget(
                          asset: AppAssets.sunset,
                          title: 'Sunset',
                          value: state.weatherInfo.sunset.format(context),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
