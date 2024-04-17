import 'package:flutter/material.dart';
import 'package:social/utils/colors/app_colors.dart';

class DarkThemeData {
  static ThemeData themeData() {
    return ThemeData(
      dividerColor: AppColors.lightPrimaryColor,
      scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
      useMaterial3: false,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBackgroundColor,
        elevation: 0,
      ),
    );
  }
}
