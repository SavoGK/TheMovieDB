import 'package:dio/dio.dart';

import '../../../core/utils/data_state.dart';

abstract class IApiService<T> {
  Future<DataState<T>> getDataFromApi(String url, {Map<String, dynamic>? params});
}
