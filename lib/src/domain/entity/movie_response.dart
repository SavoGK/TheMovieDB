import '../../data/models/movie_model.dart';
import 'dates.dart';

class MovieResponse {
  final Dates dates;
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

}
