import 'dart:async';
import '../../core/bloc/i_bloc.dart';
import '../../core/utils/data_state.dart';
import '../../core/utils/general_constants.dart';
import '../../data/data_source/remote/api_service_movie.dart';
import '../../data/repository/movie_repository.dart';
import '../../domain/usecase/implementation/get_movies_use_case.dart';

class MoviesBloc extends IBloc {
  final StreamController<DataState> _movies =
      StreamController<DataState>.broadcast();
  final GetMoviesUseCase _useCase;
  static const int _numberPage = 1;
  static const String _paramPage = 'page';
  static const String _paramGenre = 'with_genres';
  final Map<String, dynamic> _params = <String, dynamic>{};

  MoviesBloc({
    GetMoviesUseCase? useCase,
  }) : _useCase = useCase ??
            GetMoviesUseCase(
              movieRepository: MovieRepository(
                apiService: ApiServiceMovie(),
              ),
            );

  Stream<DataState> get movies => _movies.stream;

  @override
  void dispose() => _movies.close();

  void fetchMovies({
    required CategoriesMovies categories,
    String? genre,
  }) async {
    _movies.sink.add(DataLoading());
    _params[_paramPage] = '$_numberPage';
    if (genre != null) {
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
    } else if (dataState is DataEmpty) {
      _movies.sink.add(DataEmpty());
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

enum CategoriesMovies {
  topRated,
  upcoming,
  popular,
  nowPlaying,
  movie;

  String get endPoint {
    switch (this) {
      case CategoriesMovies.topRated:
        return ApiServiceConst.topRated;
      case CategoriesMovies.upcoming:
        return ApiServiceConst.upcoming;
      case CategoriesMovies.popular:
        return ApiServiceConst.popular;
      case CategoriesMovies.nowPlaying:
        return ApiServiceConst.nowPlaying;
      case CategoriesMovies.movie:
        return ApiServiceConst.movie;
    }
  }
}
