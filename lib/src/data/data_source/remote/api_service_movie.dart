import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/utils/data_state.dart';
import '../../../core/utils/general_constants.dart';
import '../../models/movie_model.dart';
import 'i_api_service.dart';

class ApiServiceMovie implements IApiService {
  final Options _options = Options(
    headers: {
      ApiServiceConst.authorization:
          ApiServiceConst.bearer + ApiServiceConst.apiKey,
    },
  );
  final Dio dio = Dio();


  static const String date = 'date';
  static const String results = 'results';


  @override
  Future<DataState> getDataFromApi(
    String endPoint, {
    Map<String, dynamic>? params,
  }) async {
    final Response response = await dio.get(
      ApiServiceConst.urlMovie + endPoint,
      queryParameters: params,
      options: _options,
    );
    if (response.statusCode == HttpStatus.ok) {
      return DataSuccess(
        List<MovieModel>.from(
          response.data[results].map((movie) => MovieModel.fromJson(movie)),
        ),
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
