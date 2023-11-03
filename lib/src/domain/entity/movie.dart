import '../../core/utils/general_constants.dart';

class Movie {
  final bool adult;
  final String thumbnail;
  final List<int> genres;
  final int idMovie;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String poster;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    required this.thumbnail,
    required this.genres,
    required this.idMovie,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.poster,
    required this.releaseDate,
    required this.title,
    required  this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  String getThumbnail() => ApiServiceConst.urlImages + thumbnail;

  String getPoster() => ApiServiceConst.urlImages + poster;
}
