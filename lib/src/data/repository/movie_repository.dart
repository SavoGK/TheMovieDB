import 'dart:async';
import '../../core/utils/data_state.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote/api_service_movie.dart';

class MovieRepository implements Repository {
  static final ApiServiceMovie apiService = ApiServiceMovie();

  @override
  Future<DataState> getData({
    String? endPoint,
    Map<String, dynamic>? params,
  }) async {
    final DataState dataState =
        await apiService.getDataFromApi(endPoint!, params: params);
    if (dataState is DataSuccess) {
      return DataSuccess(dataState.data);
    } else {
      return dataState;
    }
  }
}
