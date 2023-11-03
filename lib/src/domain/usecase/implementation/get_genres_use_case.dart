import '../../../core/utils/data_state.dart';
import '../../../data/repository/genre_repository.dart';
import '../i_usecase.dart';

class GetGenresUseCase implements IUseCase {
  final GenreRepository genreRepository;

  GetGenresUseCase({
    required this.genreRepository,
  });

  @override
  Future<DataState> call({params, String? urlType}) async =>
      await genreRepository.getData();
}
