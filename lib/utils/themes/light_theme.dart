import 'package:flutter/material.dart';
import 'package:social/utils/colors/app_colors.dart';

class LightThemeData {
  static ThemeData themeData() {
    return ThemeData(
      dividerColor: AppColors.darkPrimaryColor,
      scaffoldBackgroundColor: AppColors.lightScaffoldBackgroundColor,
      useMaterial3: false,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightScaffoldBackgroundColor,
        elevation: 0,
      ),
    );
  }
}
