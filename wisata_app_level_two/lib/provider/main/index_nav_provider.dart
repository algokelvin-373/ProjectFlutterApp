import 'package:flutter/material.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavBar = 0;

  int get indexBottomNavBar => _indexBottomNavBar;

  set setIndexBottomNavBar(int value) {
    _indexBottomNavBar = value;
    notifyListeners();
  }
}