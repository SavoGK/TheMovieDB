import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  static ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;
  static bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme () {
    _themeMode = _isDark?ThemeMode.light:ThemeMode.dark;
    _isDark = !_isDark;
    notifyListeners();
  }
}
