import 'package:flutter/material.dart';

class ShowPassProvider with ChangeNotifier {
  bool _showPass = false;
  bool get showPassValue => _showPass;
  void setShowPassValue() {
    _showPass = !_showPass;
    notifyListeners();
  }
}
