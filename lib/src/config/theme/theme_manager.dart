import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  static ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  static bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme () {
    _themeMode = _isDark?ThemeMode.dark:ThemeMode.light;
    _isDark = !_isDark;
    notifyListeners();
  }
}
