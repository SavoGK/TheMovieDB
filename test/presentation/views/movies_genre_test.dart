import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/src/config/theme/theme_manager.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/presentation/bloc/movies_bloc.dart';
import 'package:the_movie_db/src/presentation/views/movies_genre.dart';
import 'package:the_movie_db/src/presentation/widget/movies_grid.dart';
import 'package:the_movie_db/src/presentation/widget/theme_switch_button.dart';

import '../../Mock/mock_genre.dart';
import '../../Mock/mock_movie.dart';

class MockMoviesBloc extends Mock implements MoviesBloc {}

void main() {
  late MockMoviesBloc mockMoviesBloc;
  late StreamController<DataState> streamController;

  setUp(
    () {
      mockMoviesBloc = MockMoviesBloc();
      streamController = StreamController();
      registerFallbackValue(CategoriesMovies.nowPlaying);
    },
  );

  group(
    'Test Movies Genre',
    () {
      testWidgets(
        'The widget should show the information correctly with DataSuccess',
        (WidgetTester widgetTester) async {
          when(() => mockMoviesBloc.movies)
              .thenAnswer((_) => streamController.stream);
          when(
            () => mockMoviesBloc.fetchMovies(
              categories: any(named: 'categories'),
              genre: any(named: 'genre'),
            ),
          ).thenAnswer(
            (_) async {
              streamController.sink.add(
                DataSuccess(MockMovies.mockMoviesList),
              );
            },
          );
          mockNetworkImages(
            () async {
              await widgetTester.pumpWidget(
                MultiProvider(
                  providers: <SingleChildWidget>[
                    ChangeNotifierProvider<ThemeManager>(
                      create: (_) => ThemeManager(),
                    ),
                  ],
                  child: MaterialApp(
                    home: MoviesGenre(
                      genre: MockGenre.genre,
                      moviesBloc: mockMoviesBloc,
                      categories: CategoriesMovies.movie,
                    ),
                  ),
                ),
              );

              await widgetTester.pump(Duration.zero);

              expect(
                find.byType(AppBar),
                findsOneWidget,
              );

              expect(
                find.text(MockGenre.genre.name),
                findsOneWidget,
              );

              expect(
                find.byType(ThemeSwitchButton),
                findsOneWidget,
              );

              expect(
                find.byType(MoviesGrid),
                findsOneWidget,
              );
              expect(
                find.text(MockMovies.mockMoviesList[0].title),
                findsOneWidget,
              );
            },
          );
        },
      );
      testWidgets(
        'The widget should show the error message correctly with DataFailed',
        (WidgetTester widgetTester) async {
          when(() => mockMoviesBloc.movies)
              .thenAnswer((_) => streamController.stream);
          when(
            () => mockMoviesBloc.fetchMovies(
              categories: any(named: 'categories'),
              genre: any(named: 'genre'),
            ),
          ).thenAnswer(
            (_) async {
              streamController.sink.add(
                DataFailed(ResultException.exception),
              );
            },
          );
          mockNetworkImages(
            () async {
              await widgetTester.pumpWidget(
                MultiProvider(
                  providers: <SingleChildWidget>[
                    ChangeNotifierProvider<ThemeManager>(
                      create: (_) => ThemeManager(),
                    ),
                  ],
                  child: MaterialApp(
                    home: MoviesGenre(
                      genre: MockGenre.genre,
                      moviesBloc: mockMoviesBloc,
                      categories: CategoriesMovies.movie,
                    ),
                  ),
                ),
              );

              await widgetTester.pump(Duration.zero);

              expect(
                find.text('${ResultException.exception}'),
                findsOneWidget,
              );
            },
          );
        },
      );
      testWidgets(
        'The widget should show the message correctly with DataEmpty',
        (WidgetTester widgetTester) async {
          when(() => mockMoviesBloc.movies)
              .thenAnswer((_) => streamController.stream);
          when(
            () => mockMoviesBloc.fetchMovies(
              categories: any(named: 'categories'),
              genre: any(named: 'genre'),
            ),
          ).thenAnswer(
            (_) async {
              streamController.sink.add(
                DataEmpty(),
              );
            },
          );
          mockNetworkImages(
            () async {
              await widgetTester.pumpWidget(
                MultiProvider(
                  providers: <SingleChildWidget>[
                    ChangeNotifierProvider<ThemeManager>(
                      create: (_) => ThemeManager(),
                    ),
                  ],
                  child: MaterialApp(
                    home: MoviesGenre(
                      genre: MockGenre.genre,
                      moviesBloc: mockMoviesBloc,
                      categories: CategoriesMovies.movie,
                    ),
                  ),
                ),
              );

              await widgetTester.pump(Duration.zero);

              expect(
                find.byType(AppBar),
                findsOneWidget,
              );

              expect(
                find.text(MockGenre.genre.name),
                findsOneWidget,
              );

              expect(
                find.byType(ThemeSwitchButton),
                findsOneWidget,
              );

              expect(
                find.byType(MoviesGrid),
                findsOneWidget,
              );
              expect(
                find.text(MockMovies.isEmpty),
                findsOneWidget,
              );
            },
          );
        },
      );
      testWidgets(
        'The widget should show the message correctly with DataLoading',
        (WidgetTester widgetTester) async {
          when(() => mockMoviesBloc.movies)
              .thenAnswer((_) => streamController.stream);
          when(
            () => mockMoviesBloc.fetchMovies(
              categories: any(named: 'categories'),
              genre: any(named: 'genre'),
            ),
          ).thenAnswer(
            (_) async {
              streamController.sink.add(
                DataLoading(),
              );
            },
          );
          mockNetworkImages(
            () async {
              await widgetTester.pumpWidget(
                MultiProvider(
                  providers: <SingleChildWidget>[
                    ChangeNotifierProvider<ThemeManager>(
                      create: (_) => ThemeManager(),
                    ),
                  ],
                  child: MaterialApp(
                    home: MoviesGenre(
                      genre: MockGenre.genre,
                      moviesBloc: mockMoviesBloc,
                      categories: CategoriesMovies.movie,
                    ),
                  ),
                ),
              );

              await widgetTester.pump(Duration.zero);

              expect(
                find.byType(CircularProgressIndicator),
                findsOneWidget,
              );
            },
          );
        },
      );
    },
  );
}
