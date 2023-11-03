import 'dart:async';
import '../../core/bloc/i_bloc.dart';
import '../../core/utils/data_state.dart';
import '../../core/utils/general_constants.dart';
import '../../data/repository/movie_repository.dart';
import '../../domain/usecase/implementation/get_movies_use_case.dart';

class MoviesBloc extends IBloc {
  final StreamController<DataState> _movies =
      StreamController<DataState>.broadcast();
  final GetMoviesUseCase _useCase =
      GetMoviesUseCase(movieRepository: MovieRepository());
  static const int _numberPage = 1;
  static const String _paramPage = 'page';
  static const String _paramGenre = 'with_genres';
  final Map<String, dynamic> _params = <String, dynamic>{};

  Stream<DataState> get movies => _movies.stream;

  @override
  void dispose() => _movies.close();

  void fetchMovies({
    required Categories categories,
    String? genre,
  }) async {
    _movies.sink.add(DataLoading());
    _params[_paramPage] = '$_numberPage';
    if (genre == null) {
      _params[_paramGenre] = '';
    } else {
      _params[_paramGenre] = genre;
    }
    DataState dataState = await _useCase.call(
      categories: categories.endPoint,
      params: _params,
    );
    if (dataState is DataSuccess) {
      _movies.sink.add(
        DataSuccess(dataState.data),
      );
    } else {
      _movies.sink.add(
        DataFailed(dataState.error as Exception),
      );
    }
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
}

enum Categories {
  topRated,
  upcoming,
  popular,
  nowPlaying,
  movie;

  String get endPoint {
    switch (this) {
      case Categories.topRated:
        return ApiServiceConst.topRated;
      case Categories.upcoming:
        return ApiServiceConst.upcoming;
      case Categories.popular:
        return ApiServiceConst.popular;
      case Categories.nowPlaying:
        return ApiServiceConst.nowPlaying;
      case Categories.movie:
        return ApiServiceConst.movie;
    }
  }
}
