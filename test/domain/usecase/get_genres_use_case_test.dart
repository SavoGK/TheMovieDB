import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/data/repository/genre_repository.dart';
import 'package:the_movie_db/src/domain/usecase/implementation/get_genres_use_case.dart';

import '../../Mock/mock_genre.dart';
import '../../Mock/mock_movie.dart';

class MockGenreRepository extends Mock implements GenreRepository {}

void main() {
  late GetGenresUseCase getGenresUseCase;
  late MockGenreRepository mockGenresRepository;

  setUp(() {
    mockGenresRepository = MockGenreRepository();
    getGenresUseCase = GetGenresUseCase(genreRepository: mockGenresRepository);
  });

  group('Test GetMoviesUseCase', () {
    test('test call() DataSuccess', () async {
      when(
        () => mockGenresRepository.getData(),
      ).thenAnswer(
        (_) => Future.value(DataSuccess(MockGenre.genres)),
      );
      final result = await getGenresUseCase.call();
      verify(
        () => mockGenresRepository.getData(),
      );
      expect(result.data, MockGenre.genres);
    });
    test('test call() DataFailed', () async {
      when(
        () => mockGenresRepository.getData(),
      ).thenAnswer(
        (_) => Future.value(DataFailed(ResultException.exception)),
      );
      final result = await getGenresUseCase.call();
      verify(
        () => mockGenresRepository.getData(),
      );
      expect(
        result.error,
        ResultException.exception,
      );
    });
  });
}
