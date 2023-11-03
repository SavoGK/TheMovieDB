import '../../data/models/movie_model.dart';

class MovieDiscoverResponse {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieDiscoverResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

}
