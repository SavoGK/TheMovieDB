import 'dart:async';
import '../../core/utils/data_state.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote/api_service_genres.dart';
import '../models/genre_model.dart';

class GenreRepository implements Repository {
  static List<GenreModel> _genres = <GenreModel>[];
  final ApiServiceGenres apiService;
  static const String _urlGenres =
      'https://api.themoviedb.org/3/genre/movie/list';

  GenreRepository({
    required this.apiService,
  });

  @override
  Future<DataState> getData({
    String? endPoint,
    Map<String, dynamic>? params,
  }) async {
    DataState dataState;
    if (_genres.isEmpty) {
      dataState = await apiService.getDataFromApi(_urlGenres);
      if (dataState is DataSuccess) {
        _genres = dataState.data;
      }
    } else {
      dataState = DataSuccess(_genres);
    }
    if (dataState is DataSuccess) {
      return DataSuccess(dataState.data);
    } else {
      return dataState;
    }
  }
}
