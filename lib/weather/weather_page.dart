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

  Widget _additionalInfoWidget({
    required double width,
    required String asset,
    required String title,
    required String value,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.containerBackground,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: width * 1.9,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(asset, width: 20, color: AppColors.iconOverlay),
          Text(
            title,
            style: const TextStyle(color: AppColors.iconOverlay),
          ),
          Text(
            value,
            style: const TextStyle(color: AppColors.iconOverlay),
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

  Widget _verticalDivider() {
    return Container(
      width: 1.5,
      color: AppColors.iconOverlay,
      height: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          height: double.infinity,
          decoration:
              const BoxDecoration(gradient: AppColors.backgroundGradient),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.16,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.containerBackground,
                    highlightColor: AppColors.iconOverlay,
                    enabled: state.status == WeatherStatus.initial,
                    child: Text(
                      'Searching...',
                      style: AppTextStyles.boldTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '0',
                    style: AppTextStyles.boldTextStyle.copyWith(fontSize: 80),
                  ),
                ),
                Text('Cloudy', style: AppTextStyles.regularTextStyle),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('H: 0', style: AppTextStyles.regularTextStyle),
                      const SizedBox(width: 8),
                      Text('M: 0', style: AppTextStyles.regularTextStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.06,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _mainInfoRowItem(title: 'Humidity', value: '0%'),
                      _verticalDivider(),
                      _mainInfoRowItem(title: 'Visibility', value: '0'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      asset: AppAssets.sunrise,
                      title: 'Sunrise',
                      value: '0',
                    ),
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      asset: AppAssets.wind,
                      title: 'Wind',
                      value: '0',
                    ),
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      asset: AppAssets.rain,
                      title: 'Rain',
                      value: '0',
                    ),
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      asset: AppAssets.sunset,
                      title: 'Sunset',
                      value: '0',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
