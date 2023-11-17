import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/src/config/theme/theme_manager.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/core/utils/general_constants.dart';
import 'package:the_movie_db/src/presentation/bloc/movies_bloc.dart';
import 'package:the_movie_db/src/presentation/views/home_page.dart';
import 'package:the_movie_db/src/presentation/widget/drawer_genre.dart';
import 'package:the_movie_db/src/presentation/widget/movies_grid.dart';
import 'package:the_movie_db/src/presentation/widget/theme_switch_button.dart';
import '../../Mock/mock_movie.dart';

class MockMoviesBloc extends Mock implements MoviesBloc {}

void main() {
  late MockMoviesBloc mockMoviesBloc;
  late StreamController<DataState> streamController;

  setUp(
    () {
      streamController = StreamController();
      mockMoviesBloc = MockMoviesBloc();
      registerFallbackValue(CategoriesMovies.nowPlaying);
    },
  );
  group(
    'Test Home Page',
    () {
      testWidgets(
        'The widget should show the information correctly with DataSuccess'
        'and show Movies Grid',
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
                    home: HomePage(
                      moviesBloc: mockMoviesBloc,
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
                find.text(AppName.name),
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
        'The widget should show the information correctly with DataEmpty',
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
                    home: HomePage(
                      moviesBloc: mockMoviesBloc,
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
                find.text(AppName.name),
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
                    home: HomePage(
                      moviesBloc: mockMoviesBloc,
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
    },
  );
}
