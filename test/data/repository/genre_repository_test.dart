import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/data/data_source/remote/api_service_genres.dart';
import 'package:the_movie_db/src/data/repository/genre_repository.dart';

import '../../Mock/mock_genre.dart';
import '../../Mock/mock_movie.dart';

class MockApiServiceGenres extends Mock implements ApiServiceGenres {}

void main() {
  late MockApiServiceGenres mockApiServiceGenres;
  late GenreRepository genreRepository;

  setUp(() {
    mockApiServiceGenres = MockApiServiceGenres();
    genreRepository = GenreRepository(apiService: mockApiServiceGenres);
  });

  group('Repository genre test', () {
    test('getData() is DataFailed', () async {
      when(() => mockApiServiceGenres.getDataFromApi(any())).thenAnswer(
        (_) => Future.value(DataFailed(ResultException.exception)),
      );
      final result =
          await genreRepository.getData(endPoint: MockGenre.urlGenres);
      verify(
        () => mockApiServiceGenres.getDataFromApi(MockGenre.urlGenres),
      ).called(1);
      expect(result, isA<DataFailed>());
      expect(result.error, ResultException.exception);
    });
    test('getData() is DataSuccess', () async {
      when(() => mockApiServiceGenres.getDataFromApi(any())).thenAnswer(
        (_) => Future.value(
          DataSuccess(MockGenre.genres),
        ),
      );
      final result =
          await genreRepository.getData(endPoint: MockGenre.urlGenres);
      verify(() => mockApiServiceGenres.getDataFromApi(MockGenre.urlGenres))
          .called(1);
      expect(
        result,
        isA<DataSuccess>(),
      );
      expect(
        result.data,
        MockGenre.genres,
      );
    });
  });
}
