import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
