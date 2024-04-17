import 'package:flutter/material.dart';

class SelectedPageProvider extends ChangeNotifier {
  int selectedPageIndex = 0;
  int get getSelectedPageIndex => selectedPageIndex;
  late PageController controller; // تعريف controller بدون تهيئة في هذا السياق
  void setSelectedPageIndex({required int pageIndex}) {
    selectedPageIndex = pageIndex;
    notifyListeners();
  }

  // Constructor
  SelectedPageProvider() {
    // تهيئة controller في البناء الفعلي للكائن
    controller = PageController(initialPage: selectedPageIndex);
  }

  void getNextPageIndex(value) {
    selectedPageIndex = value;
    controller.jumpToPage(selectedPageIndex);
    notifyListeners();
  }
}
