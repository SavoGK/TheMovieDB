import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movie_db/src/core/utils/data_state.dart';
import 'package:the_movie_db/src/core/utils/general_constants.dart';
import 'package:the_movie_db/src/data/data_source/remote/api_service_movie.dart';
import 'package:the_movie_db/src/data/repository/movie_repository.dart';
import '../../Mock/mock_movie.dart';

class MockApiServiceMovie extends Mock implements ApiServiceMovie {}

void main() {
  late MockApiServiceMovie mockApiServiceMovie;
  late MovieRepository movieRepository;

  setUp(() {
    mockApiServiceMovie = MockApiServiceMovie();
    movieRepository = MovieRepository(apiService: mockApiServiceMovie);
  });

  group(
    'Test getData',
    () {
      test(
        'getData() Success',
        () async {
          when(
            () => mockApiServiceMovie.getDataFromApi(
              ApiServiceConst.upcoming,
              params: any(named: 'params'),
            ),
          ).thenAnswer(
            (_) => Future.value(
              DataSuccess(MockMovies.mockMoviesList),
            ),
          );
          final result = await movieRepository.getData(
            endPoint: ApiServiceConst.upcoming,
            params: Parameters.params,
          );
          verify(
            () => mockApiServiceMovie.getDataFromApi(
              ApiServiceConst.upcoming,
              params: Parameters.params,
            ),
          ).called(1);
          expect(result, isA<DataSuccess>());
          expect(
            result.data,
            MockMovies.mockMoviesList,
          );
        },
      );

      test(
        'getData() Failed',
        () async {
          when(
            () => mockApiServiceMovie.getDataFromApi(
              ApiServiceConst.upcoming,
              params: any(named: 'params'),
            ),
          ).thenAnswer(
            (_) => Future.value(
              DataFailed(ResultException.exception),
            ),
          );
          final result = await movieRepository.getData(
            endPoint: ApiServiceConst.upcoming,
            params: Parameters.params,
          );
          verify(
            () => mockApiServiceMovie.getDataFromApi(
              ApiServiceConst.upcoming,
              params: Parameters.params,
            ),
          ).called(1);
          expect(
            result,
            isA<DataFailed>(),
          );
          expect(
            result.error,
            ResultException.exception,
          );
        },
      );
    },
  );
}
