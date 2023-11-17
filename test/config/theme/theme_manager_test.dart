import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/src/config/theme/theme_manager.dart';

void main() {
  late ThemeManager themeManager;

  setUp(
    () {
      themeManager = ThemeManager();
    },
  );

  test(
    'Test toggleTheme()',
    () {
      expect(
        themeManager.themeMode,
        ThemeMode.dark,
      );
      expect(
        themeManager.isDark,
        true,
      );

      themeManager.toggleTheme();

      expect(
        themeManager.themeMode,
        ThemeMode.light,
      );
      expect(
        themeManager.isDark,
        false,
      );

      themeManager.toggleTheme();

      expect(
        themeManager.themeMode,
        ThemeMode.dark,
      );
      expect(
        themeManager.isDark,
        true,
      );
    },
  );
}
