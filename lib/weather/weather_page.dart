import 'package:cl_weather_app/common/app_assets.dart';
import 'package:cl_weather_app/common/ui/app_colors.dart';
import 'package:cl_weather_app/common/ui/app_text_styles.dart';
import 'package:cl_weather_app/weather/bloc/weather_bloc.dart';
import 'package:cl_weather_app/weather/bloc/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  void _blocListener(BuildContext context, WeatherState state) {
    if (state.status == WeatherStatus.locationDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enable location service to get weather info',
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      );
    } else if (state.status == WeatherStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error happened while loading data',
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      );
    }
  }

  Widget _additionalInfoWidget({
    required String asset,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.containerBackground,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(asset, width: 25.w, color: AppColors.iconOverlay),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: AppColors.iconOverlay,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              value,
              style: TextStyle(color: AppColors.iconOverlay, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainInfoRowItem({required String title, required String value}) {
    return Column(
      children: [
        Text(title, style: AppTextStyles.regularTextStyle),
        SizedBox(height: 8.h),
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
            padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                  SizedBox(height: 8.h),
                  Text(
                    '${state.weatherInfo.currentTemp}°',
                    style: AppTextStyles.boldTextStyle.copyWith(
                      fontSize: 80.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.weatherInfo.weatherDescription,
                    style: AppTextStyles.regularTextStyle,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'H: ${state.weatherInfo.maxTemp}°',
                        style: AppTextStyles.regularTextStyle,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'M: ${state.weatherInfo.minTemp}°',
                        style: AppTextStyles.regularTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _mainInfoRowItem(
                        title: 'Humidity',
                        value: '${state.weatherInfo.humidity}%',
                      ),
                      Container(
                        width: 1.5.w,
                        color: AppColors.iconOverlay,
                        height: 40.h,
                      ),
                      _mainInfoRowItem(
                        title: 'Visibility',
                        value: '${state.weatherInfo.visibility} km',
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
