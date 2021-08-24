import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Colors.black;
  static const textPrimaryColor = Color.fromRGBO(255, 255, 255, 0.8);

  // background
  static const _topGradientColor = Color.fromRGBO(45, 71, 152, 1);
  static const _bottomGradientColor = Color.fromRGBO(103, 130, 182, 1);
  static const backgroundGradient = LinearGradient(
    transform: GradientRotation(3.14 / 2),
    colors: [_topGradientColor, _bottomGradientColor],
  );

  // widgets
  static const iconOverlay = Color.fromRGBO(53, 71, 118, 1.0);
  static const containerBackground = Color.fromRGBO(196, 217, 254, 1);
}
