import 'package:flutter/material.dart';

class IsLikeProvider extends ChangeNotifier {
  bool isLike = false;
  bool get getIsLike => isLike;
  void setIsLike(bool newLike) {
    isLike = !newLike;
    notifyListeners();
  }
}
