import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme/theme_manager.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (
        BuildContext context,
        ThemeManager themeManager,
        Widget? child,
      ) {
        return IconButton(
          icon: Icon(
            themeManager.isDark ? Icons.nightlight_round : Icons.sunny,
          ),
          onPressed: () {
            themeManager.toggleTheme();
          },
        );
      },
    );
  }
}
