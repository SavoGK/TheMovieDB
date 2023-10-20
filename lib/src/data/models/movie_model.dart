import '../../domain/entity/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.adult,
    required super.thumbnail,
    required super.genres,
    required super.idMovie,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.poster,
    required super.releaseDate,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json ['adult'],
      thumbnail: json ['backdrop_path'],
      genres: List<int>.from(json ['genre_ids']),
      idMovie: json ['id'],
      originalLanguage: json ['original_language'],
      originalTitle: json ['original_title'],
      overview: json ['overview'],
      popularity: json ['popularity'],
      poster: json ['poster_path'],
      releaseDate: json ['release_date'],
      title: json ['title'],
      video: json ['video'],
      voteAverage: (json ['vote_average']).toDouble(),
      voteCount: json ['vote_count'],
    );
  }

}
