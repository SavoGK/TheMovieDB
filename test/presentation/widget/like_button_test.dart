import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/src/presentation/widget/like_button.dart';

void main() {
  const int likes = 0;
  const int likesPlusOne = 1;
  testWidgets(
    'Test tap like_button',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: LikeButton(like: likes),
        ),
      );
      expect(
        find.text('$likes'),
        findsOneWidget,
      );
      final incrementLikes = find.byType(Icon);
      await widgetTester.tap(incrementLikes);
      await widgetTester.pumpAndSettle();
      expect(
        find.text('$likesPlusOne'),
        findsOneWidget,
      );
      await widgetTester.tap(incrementLikes);
      await widgetTester.pumpAndSettle();
      expect(
        find.text('$likes'),
        findsOneWidget,
      );
    },
  );
}
