import 'package:cl_weather_app/common/ui/app_colors.dart';
import 'package:cl_weather_app/common/ui/app_text_styles.dart';
import 'package:cl_weather_app/weather/bloc/weather_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  Widget _additionalInfoWidget({
    required double width,
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
          Icon(Icons.ac_unit),
          Text(title),
          Text(value),
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
                  child: Text(
                    'Rostov',
                    style: AppTextStyles.boldTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '27',
                    style: AppTextStyles.boldTextStyle.copyWith(fontSize: 80),
                  ),
                ),
                Text('Cloudy', style: AppTextStyles.regularTextStyle),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('H: 27', style: AppTextStyles.regularTextStyle),
                      const SizedBox(width: 8),
                      Text('M: 13', style: AppTextStyles.regularTextStyle),
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
                      _mainInfoRowItem(title: 'Humidity', value: '20%'),
                      _verticalDivider(),
                      _mainInfoRowItem(title: 'Rain', value: '20%'),
                      _verticalDivider(),
                      _mainInfoRowItem(title: 'Wind', value: '20'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      title: 'Now',
                      value: '23',
                    ),
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      title: 'Now',
                      value: '23',
                    ),
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      title: 'Now',
                      value: '23',
                    ),
                    _additionalInfoWidget(
                      width: MediaQuery.of(context).size.width / 6,
                      title: 'Now',
                      value: '23',
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
