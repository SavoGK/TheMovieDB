import '../utils/data_state.dart';
import 'i_bloc.dart';

abstract class IGenresBloc extends IBloc{
  Stream<DataState> get genres;
  void fetchGenres();
}
