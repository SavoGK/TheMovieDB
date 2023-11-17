import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/utils/data_state.dart';
import '../../../core/utils/general_constants.dart';
import '../../../domain/entity/movie.dart';
import '../../models/movie_model.dart';
import 'i_api_service.dart';

class ApiServiceMovie implements IApiService {
  final Options _options = Options(
    headers: <String, dynamic>{
      ApiServiceConst.authorization:
          ApiServiceConst.bearer + ApiServiceConst.apiKey,
    },
  );
  final Dio dio = Dio();

  static const String date = 'date';
  static const String results = 'results';

  @override
  Future<DataState<List<Movie>>> getDataFromApi(
    String endPoint, {
    Map<String, dynamic>? params,
  }) async {
    final Response response = await dio.get(
      ApiServiceConst.urlMovie + endPoint,
      queryParameters: params,
      options: _options,
    );
    if (response.statusCode == HttpStatus.ok) {
      if (response.data != null) {
        return DataSuccess<List<Movie>>(
          List<MovieModel>.from(
            response.data[results].map(
              (movie) => MovieModel.fromJson(movie),
            ),
          ),
        );
      } else {
        return DataEmpty();
      }
    } else {
      return DataFailed(
        DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ),
      );
    }
  }
}
