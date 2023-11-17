import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:the_movie_db/src/presentation/widget/movie_poster.dart';
import '../../Mock/mock_movie.dart';

void main() {
  testWidgets(
    'Test Movie Poster',
    (WidgetTester widgetTester) async {
      mockNetworkImages(
        () async {
          await widgetTester.pumpWidget(
            MaterialApp(
              home: MoviePoster(
                movie: MockMovies.mockMovie,
              ),
            ),
          );
          expect(
            find.byType(Image),
            findsOneWidget,
          );
          expect(
            find.text(MockMovies.mockMovie.title),
            findsOneWidget,
          );
        },
      );
    },
  );
}
