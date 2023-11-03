import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/utils/data_state.dart';
import '../../../core/utils/general_constants.dart';
import '../../models/genre_model.dart';
import 'i_api_service.dart';

class ApiServiceGenres implements IApiService {
  final Options _options = Options(
    headers: {
      ApiServiceConst.authorization:
          ApiServiceConst.bearer + ApiServiceConst.apiKey,
    },
  );
  final Dio dio = Dio();

  Future<Response> getMovies(String url) async {
    return await dio.get(url, options: _options);
  }

  @override
  Future<DataState> getDataFromApi(
    String url, {
        Map<String, dynamic>? params,
}) async {
    final Response response = await dio.get(url, options: _options);
    if (response.statusCode == HttpStatus.ok) {
      final genresList = response.data['genres'];
      List<GenreModel> genres = List<GenreModel>.from(
        genresList.map((genre) => GenreModel.fromJson(genre)),
      );
      return DataSuccess(
        genres,
      );
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
