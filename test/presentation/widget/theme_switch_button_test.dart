import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/src/config/theme/theme_manager.dart';
import 'package:the_movie_db/src/presentation/widget/theme_switch_button.dart';

void main() {
  testWidgets(
    'Test theme switch button, test the toggleTheme change the icon',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: <SingleChildWidget>[
              ChangeNotifierProvider(create: (_) => ThemeManager()),
            ],
            child: const Material(
              child: ThemeSwitchButton(),
            ),
          ),
        ),
      );
      expect(
        find.byType(Icon),
        findsOneWidget,
      );
      expect(
        find.byIcon(Icons.nightlight_round),
        findsOneWidget,
      );
      await widgetTester.tap(find.byType(Icon));
      await widgetTester.pumpAndSettle();
      expect(
        find.byType(Icon),
        findsOneWidget,
      );
      expect(
        find.byIcon(Icons.sunny),
        findsOneWidget,
      );
    },
  );
}
