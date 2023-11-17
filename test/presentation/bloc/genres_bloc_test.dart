import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/domain/usecase/implementation/get_genres_use_case.dart';
import 'package:the_movie_db/src/presentation/bloc/genres_bloc.dart';

import '../../Mock/mock_genre.dart';
import '../../Mock/mock_movie.dart';

class MockGetGenresUseCase extends Mock implements GetGenresUseCase {}

void main() {
  late GenresBloc genresBloc;
  late MockGetGenresUseCase mockGetGenresUseCase;

  setUp(() {
    mockGetGenresUseCase = MockGetGenresUseCase();
    genresBloc = GenresBloc( useCase: mockGetGenresUseCase);
  });

  group(
    'GenresBloc test',
    () {
      test(
        'Test fetchGenres() DataSuccess',
        () async {
          when(
            () => mockGetGenresUseCase.call(),
          ).thenAnswer(
            (_) => Future.value(DataSuccess(MockGenre.genres)),
          );
          genresBloc.fetchGenres();
          verify(
            () => mockGetGenresUseCase.call(),
          ).called(1);
          final result = await genresBloc.genres.first;
          expect(
            result.data,
            MockGenre.genres,
          );
        },
      );
      test(
        'Test fetchGenres() DataFailed',
        () async {
          when(
            () => mockGetGenresUseCase.call(),
          ).thenAnswer(
            (_) => Future.value(DataFailed(ResultException.exception)),
          );
          genresBloc.fetchGenres();
          verify(
            () => mockGetGenresUseCase.call(),
          ).called(1);
          final result = await genresBloc.genres.first;
          expect(
            result.error,
            ResultException.exception,
          );
        },
      );
    },
  );
}
