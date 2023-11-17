import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/src/config/theme/theme_manager.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/core/utils/general_constants.dart';
import 'package:the_movie_db/src/data/models/genre_model.dart';
import 'package:the_movie_db/src/domain/usecase/implementation/get_genres_use_case.dart';
import 'package:the_movie_db/src/presentation/bloc/genres_bloc.dart';
import 'package:the_movie_db/src/presentation/widget/drawer_genre.dart';
import '../../Mock/mock_genre.dart';
import '../../Mock/mock_movie.dart';

class MockGetGenresUseCase extends Mock implements GetGenresUseCase {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockGetGenresUseCase mockGetGenresUseCase;
  late GenresBloc genresBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  const String nowPlaying = 'NowPlaying';
  const String popular = 'Popular';
  const String topRated = 'Top Rated';
  const String upcoming = 'Upcoming';

  const int numberWidget = 5;

  setUp(
    () {
      mockGetGenresUseCase = MockGetGenresUseCase();
      genresBloc = GenresBloc(useCase: mockGetGenresUseCase);
      mockNavigatorObserver = MockNavigatorObserver();
    },
  );
  group(
    'Test Drawer Genre',
    () {
      testWidgets(
        'Widgets inside the Drawer should be displayed correctly '
        'with DataSuccess',
        (WidgetTester widgetTester) async {
          when(() => mockGetGenresUseCase.call()).thenAnswer(
            (_) => Future.value(DataSuccess(MockGenre.genres)),
          );
          await widgetTester.pumpWidget(
            MultiProvider(
              providers: <SingleChildWidget>[
                ChangeNotifierProvider(create: (_) => ThemeManager()),
              ],
              child: MaterialApp(
                home: DrawerGenre(
                  genresBloc: genresBloc,
                ),
                navigatorObservers: <NavigatorObserver>[mockNavigatorObserver],
              ),
            ),
          );
          await widgetTester.pump(Duration.zero);

          expect(
            find.byType(Drawer),
            findsOneWidget,
          );

          expect(
            find.byType(ListTile),
            findsNWidgets(numberWidget),
          );

          expect(
            find.text(nowPlaying),
            findsOneWidget,
          );
          expect(
            find.text(popular),
            findsOneWidget,
          );
          expect(
            find.text(upcoming),
            findsOneWidget,
          );
          expect(
            find.text(topRated),
            findsOneWidget,
          );
          expect(
            find.text(TitleStrings.genders),
            findsOneWidget,
          );

          await widgetTester.tap(find.text(TitleStrings.genders));
          await widgetTester.pumpAndSettle();

          for (GenreModel gender in MockGenre.genres) {
            expect(
              find.text(gender.name),
              findsOneWidget,
            );
          }
        },
      );
      testWidgets(
        'A text error should be show with DataFailed',
        (WidgetTester widgetTester) async {
          when(() => mockGetGenresUseCase.call()).thenAnswer(
            (_) => Future.value(DataFailed(ResultException.exception)),
          );
          await widgetTester.pumpWidget(
            MultiProvider(
              providers: <SingleChildWidget>[
                ChangeNotifierProvider(create: (_) => ThemeManager()),
              ],
              child: MaterialApp(
                home: DrawerGenre(
                  genresBloc: genresBloc,
                ),
                navigatorObservers: <NavigatorObserver>[mockNavigatorObserver],
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
}
