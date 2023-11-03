import '../../core/utils/data_state.dart';

abstract class Repository<T> {
  Future<DataState> getData({
    String endPoint,
    Map<String, dynamic>? params,
  });
}
