import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_db/src/data/models/genre_model.dart';
import 'package:the_movie_db/src/presentation/widget/genres_row.dart';

import '../../Mock/mock_genre.dart';

void main() {
  testWidgets(
    'Test Genres Row, show Text with genres',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: GenresRow(genres: MockGenre.genres),
        ),
      );
      for (GenreModel genre in MockGenre.genres) {
        expect(
          find.text(genre.name),
          findsOneWidget,
        );
      }
    },
  );
}
