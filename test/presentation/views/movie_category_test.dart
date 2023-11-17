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
import 'package:the_movie_db/src/presentation/views/movie_category.dart';
import 'package:the_movie_db/src/presentation/widget/theme_switch_button.dart';

import '../../Mock/mock_movie.dart';

class MockMoviesBloc extends Mock implements MoviesBloc {}

void main() {
  const String nowPlaying = 'NowPlaying';
  late StreamController<DataState> streamController;
  late MockMoviesBloc mockMoviesBloc;

  setUp(
    () {
      mockMoviesBloc = MockMoviesBloc();
      streamController = StreamController();
      registerFallbackValue(CategoriesMovies.nowPlaying);
    },
  );

  group(
    'Test Movie Category',
    () {
      testWidgets(
        'The widget should show the information correctly with DataSuccess',
        (WidgetTester widgetTester) async {
          when(() => mockMoviesBloc.movies)
              .thenAnswer((_) => streamController.stream);
          when(
            () => mockMoviesBloc.fetchMovies(
              categories: any(named: 'categories'),
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
                    home: MoviesCategory(
                      moviesBloc: mockMoviesBloc,
                      nameCategory: nowPlaying,
                      categories: CategoriesMovies.nowPlaying,
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
                find.text(nowPlaying),
                findsOneWidget,
              );

              expect(
                find.byType(ThemeSwitchButton),
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
                    home: MoviesCategory(
                      moviesBloc: mockMoviesBloc,
                      nameCategory: nowPlaying,
                      categories: CategoriesMovies.nowPlaying,
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
        'The widget should show the information correctly with DataLoading',
        (WidgetTester widgetTester) async {
          when(() => mockMoviesBloc.movies)
              .thenAnswer((_) => streamController.stream);
          when(
            () => mockMoviesBloc.fetchMovies(
              categories: any(named: 'categories'),
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
                    home: MoviesCategory(
                      moviesBloc: mockMoviesBloc,
                      nameCategory: nowPlaying,
                      categories: CategoriesMovies.nowPlaying,
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
