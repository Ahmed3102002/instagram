import 'package:flutter/material.dart';

class IsLoadingProvider extends ChangeNotifier {
  bool isLoading = false;
  bool get getIsLoading => isLoading;
  void get setIsLoading {
    isLoading = !isLoading;
    notifyListeners();
  }
}
