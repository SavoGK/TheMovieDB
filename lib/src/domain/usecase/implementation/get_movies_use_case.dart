import '../../../core/utils/data_state.dart';
import '../../../data/repository/movie_repository.dart';
import '../i_usecase.dart';

class GetMoviesUseCase implements IUseCase {
  final MovieRepository movieRepository;

  GetMoviesUseCase({
    required this.movieRepository,
  });

  @override
  Future<DataState> call({params, categories}) async =>
      await movieRepository.getData(
        endPoint: categories,
        params: params,
      );
}
