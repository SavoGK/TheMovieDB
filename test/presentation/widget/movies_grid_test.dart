import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:the_movie_db/src/domain/entity/movie.dart';
import 'package:the_movie_db/src/presentation/widget/movies_grid.dart';
import '../../Mock/mock_movie.dart';

void main() {

  group(
    'Test Movies Grid',
    () {
      testWidgets(
        'MoviesGrid with movies should display GridView',
        (WidgetTester widgetTester) async {
          mockNetworkImages(
            () async {
              await widgetTester.pumpWidget(
                MaterialApp(
                  home: Scaffold(
                    body: MoviesGrid(
                      movies: MockMovies.mockMoviesList,
                    ),
                  ),
                ),
              );

              expect(
                find.byType(GridView),
                findsOneWidget,
              );
              expect(
                find.text(MockMovies.mockMoviesList[0].title),
                findsOneWidget,
              );
              expect(
                find.text('There`s not movies of this genre yet'),
                findsNothing,
              );
            },
          );
        },
      );
      testWidgets(
        'MoviesGrid without movies should display error message',
        (WidgetTester widgetTester) async {
          mockNetworkImages(
                () async {
              await widgetTester.pumpWidget(
                const MaterialApp(
                  home: Scaffold(
                    body: MoviesGrid(
                      movies: <Movie>[],
                    ),
                  ),
                ),
              );

              expect(
                find.byType(Center),
                findsOneWidget,
              );
              expect(
                find.text('There`s not movies of this genre yet'),
                findsOneWidget,
              );
            },
          );
        },
      );
    },
  );
}
