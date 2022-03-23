import 'package:cl_weather_app/common/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static final TextStyle _text = TextStyle(
    fontStyle: FontStyle.normal,
    color: AppColors.textPrimaryColor,
    fontSize: 14.sp,
  );

  // Light
  static TextStyle lightTextStyle = _text.copyWith(
    fontWeight: FontWeight.w300,
  );

  // Regular
  static TextStyle regularTextStyle = _text.copyWith(
    fontWeight: FontWeight.normal,
    fontSize: 18.sp,
  );

  // Medium
  static TextStyle mediumTextStyle = _text.copyWith(
    fontWeight: FontWeight.w500,
  );

  // Bold
  static TextStyle boldTextStyle = _text.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 32.sp,
  );
}
