import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/src/presentation/widget/score_card.dart';

void main() {
  const double score = 0;

  testWidgets('Test ScoreCard', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: ScoreCard(score: score),
      ),
    );
    expect(
      find.text('$score'),
      findsOneWidget,
    );
  });
}
