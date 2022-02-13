import 'package:flutter/material.dart';

class CalenderPageModel extends ChangeNotifier {
  int index = 0;

  void changePage(pageIndex) {
    index = pageIndex;
    notifyListeners();
  }
}
