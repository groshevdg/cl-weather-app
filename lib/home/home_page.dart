import 'package:flutter/material.dart';
import 'package:cl_weather_app/common/ui/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Text(
          'Hello world',
          style: AppTextStyles.lightTextStyle,
        ),
      ),
    );
  }
}
