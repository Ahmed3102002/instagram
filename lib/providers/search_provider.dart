import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String searchText = '';
  String get getSearchText => searchText;
  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }
}
