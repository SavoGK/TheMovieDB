import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/config/theme/theme_constants.dart';
import 'src/config/theme/theme_manager.dart';
import 'src/presentation/views/home_page.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => ThemeManager(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeManager themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
