import 'dart:async';

import '../../core/bloc/i_bloc.dart';
import '../../core/utils/data_state.dart';
import '../../data/data_source/remote/api_service_genres.dart';
import '../../data/repository/genre_repository.dart';
import '../../domain/usecase/implementation/get_genres_use_case.dart';

class GenresBloc extends IBloc {
  late final GetGenresUseCase _useCase;
  final StreamController<DataState> _genres =
      StreamController<DataState>.broadcast();

  GenresBloc({
    GetGenresUseCase? useCase,
  }) : _useCase = useCase ??
            GetGenresUseCase(
              genreRepository: GenreRepository(
                apiService: ApiServiceGenres(),
              ),
            );

  Stream<DataState> get genres => _genres.stream;

  void fetchGenres() async {
    DataState dataState = await _useCase.call();
    if (dataState is DataSuccess) {
      _genres.sink.add(DataSuccess(dataState.data));
    } else {
      _genres.sink.add(DataFailed(dataState.error as Exception));
    }
  }

  @override
  void dispose() => _genres.close();

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
}
