import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String themeState = 'THEME_STATE';
  bool darkTheme = false;
  bool get getIsDarkTheme => darkTheme;
  ThemeProvider() {
    getTheme();
  }
  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(themeState, themeValue);
    darkTheme = themeValue;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    darkTheme = preferences.getBool(themeState) ?? false;
    notifyListeners();
    return darkTheme;
  }
}
