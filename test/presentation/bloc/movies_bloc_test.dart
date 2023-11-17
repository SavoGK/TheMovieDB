import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/domain/usecase/implementation/get_movies_use_case.dart';
import 'package:the_movie_db/src/presentation/bloc/movies_bloc.dart';

import '../../Mock/mock_movie.dart';

class MockGetMoviesUseCase extends Mock implements GetMoviesUseCase {}

void main() {
  late MoviesBloc moviesBloc;
  late MockGetMoviesUseCase mockGetMoviesUseCase;

  setUp(() {
    mockGetMoviesUseCase = MockGetMoviesUseCase();
    moviesBloc = MoviesBloc(useCase: mockGetMoviesUseCase);
  });

  group(
    'MoviesBloc test',
    () {
      test(
        'Test fetchMovies()',
        () async {
          when(
            () => mockGetMoviesUseCase.call(
              categories: any(named: 'categories'),
              params: any(named: 'params'),
            ),
          ).thenAnswer(
            (_) => Future.value(DataSuccess(MockMovies.mockMoviesList)),
          );
          moviesBloc.fetchMovies(categories: CategoriesMovies.upcoming);
          verify(
            () => mockGetMoviesUseCase.call(
              categories: any(named: 'categories'),
              params: any(named: 'params'),
            ),
          ).called(1);
          final result = await moviesBloc.movies.first;
          expect(
            result.data,
            MockMovies.mockMoviesList,
          );
        },
      );
      test(
        'Test fetchMovies() DataFailed',
        () async {
          when(
                () => mockGetMoviesUseCase.call(
              categories: any(named: 'categories'),
              params: any(named: 'params'),
            ),
          ).thenAnswer(
                (_) => Future.value(DataFailed(ResultException.exception)),
          );
          moviesBloc.fetchMovies(categories: CategoriesMovies.upcoming);
          verify(
                () => mockGetMoviesUseCase.call(
              categories: any(named: 'categories'),
              params: any(named: 'params'),
            ),
          ).called(1);
          final result = await moviesBloc.movies.first;
          expect(
            result.error,
            ResultException.exception,
          );
        },
      );
    },
  );
}
