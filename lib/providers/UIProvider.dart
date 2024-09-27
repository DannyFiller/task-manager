import 'package:flutter/material.dart';

class Uiprovider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  changeTheme() {
    _isDark = !isDark;
    notifyListeners();
  }

  init() {
    notifyListeners();
  }
}
