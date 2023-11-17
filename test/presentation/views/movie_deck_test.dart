import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/src/config/theme/theme_manager.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/core/utils/general_constants.dart';
import 'package:the_movie_db/src/presentation/bloc/genres_bloc.dart';
import 'package:the_movie_db/src/presentation/views/movie_deck.dart';
import 'package:the_movie_db/src/presentation/widget/genres_row.dart';
import 'package:the_movie_db/src/presentation/widget/like_button.dart';
import 'package:the_movie_db/src/presentation/widget/loader_image.dart';
import 'package:the_movie_db/src/presentation/widget/score_card.dart';
import 'package:the_movie_db/src/presentation/widget/theme_switch_button.dart';

import '../../Mock/mock_genre.dart';
import '../../Mock/mock_movie.dart';

class MockGenresBloc extends Mock implements GenresBloc {}

void main() {
  late MockGenresBloc mockGenresBloc;
  late StreamController<DataState> streamController;
  const int numberTexts = 2;
  const String description = 'Description';

  setUp(() {
    mockGenresBloc = MockGenresBloc();
    streamController = StreamController();
  });

  group(
    'Test Movie Deck',
    () {
      testWidgets(
        'The widget should show the information correctly with DataSuccess',
        (WidgetTester widgetTester) async {
          when(() => mockGenresBloc.genres)
              .thenAnswer((_) => streamController.stream);
          when(() => mockGenresBloc.fetchGenres()).thenAnswer(
            (_) async {
              streamController.sink.add(
                DataSuccess(MockGenre.genres),
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
                    home: MovieDeck(
                      movie: MockMovies.mockMovie,
                      genresBloc: mockGenresBloc,
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
                find.text(MockMovies.mockMovie.title),
                findsNWidgets(numberTexts),
              );

              expect(
                find.byType(ThemeSwitchButton),
                findsOneWidget,
              );

              expect(
                find.byType(LoaderImage),
                findsOneWidget,
              );
              expect(
                find.byType(ScoreCard),
                findsOneWidget,
              );

              expect(
                find.text(MockMovies.mockMovie.releaseDate),
                findsOneWidget,
              );

              expect(
                find.text(TitleStrings.genders),
                findsOneWidget,
              );
              expect(
                find.byType(GenresRow),
                findsOneWidget,
              );

              expect(
                find.text(description),
                findsOneWidget,
              );
              expect(
                find.text(MockMovies.mockMovie.overview),
                findsOneWidget,
              );

              expect(
                find.byType(LikeButton),
                findsOneWidget,
              );
            },
          );
        },
      );
      testWidgets(
        'The widget should show the error message correctly with DataFailed',
        (WidgetTester widgetTester) async {
          when(() => mockGenresBloc.genres)
              .thenAnswer((_) => streamController.stream);
          when(() => mockGenresBloc.fetchGenres()).thenAnswer(
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
                    home: MovieDeck(
                      movie: MockMovies.mockMovie,
                      genresBloc: mockGenresBloc,
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
