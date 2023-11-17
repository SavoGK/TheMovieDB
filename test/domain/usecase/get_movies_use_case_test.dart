import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/core/utils/general_constants.dart';
import 'package:the_movie_db/src/data/repository/movie_repository.dart';
import 'package:the_movie_db/src/domain/usecase/implementation/get_movies_use_case.dart';
import 'package:the_movie_db/src/presentation/bloc/movies_bloc.dart';

import '../../Mock/mock_movie.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMoviesUseCase getMoviesUseCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMoviesUseCase = GetMoviesUseCase(movieRepository: mockMovieRepository);
  });

  group('Test GetMoviesUseCase', () {
    test('test call() DataSuccess', () async {
      when(
        () => mockMovieRepository.getData(endPoint: any(named: 'endPoint')),
      ).thenAnswer(
        (_) => Future.value(DataSuccess(MockMovies.mockMoviesList)),
      );
      final result = await getMoviesUseCase.call(
          categories: CategoriesMovies.upcoming.endPoint);
      verify(
        () => mockMovieRepository.getData(endPoint: ApiServiceConst.upcoming),
      );
      expect(
        result.data,
        MockMovies.mockMoviesList,
      );
    });
    test('test call() DataFailed', () async {
      when(
        () => mockMovieRepository.getData(endPoint: any(named: 'endPoint')),
      ).thenAnswer(
        (_) => Future.value(DataFailed(ResultException.exception)),
      );
      final result = await getMoviesUseCase.call(
          categories: CategoriesMovies.upcoming.endPoint);
      verify(
        () => mockMovieRepository.getData(endPoint: ApiServiceConst.upcoming),
      );
      expect(
        result.error,
        ResultException.exception,
      );
    });
  });
}
