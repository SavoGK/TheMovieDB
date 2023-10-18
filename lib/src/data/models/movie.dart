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

  factory Movie.mockMovie() => Movie(
    adult: false,
    title: 'The Super Mario Bros. Movie',
    originalTitle: 'The Super Mario Bros. Movie',
    thumbnail: 'images/backdrop_mario_bros_movie.jpg',
    genres: [1,2,3],
    idMovie: 0,
    originalLanguage: 'es',
    poster: 'images/poster_mario_bros_movie.jpg',
    overview: 'While working underground to fix a water main, Brooklyn '
        'plumbers—and brothers—Mario and Luigi are transported down a '
        'mysterious pipe and wander into a magical new world. But when the '
        'brothers are separated, Mario embarks on an epic quest to find '
        'Luigi.',
    popularity: 0.0,
    releaseDate: '1999-09-21',
    video: false,
    voteAverage: 7.8,
    voteCount: 5,
  );

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json ['adult'],
      thumbnail: json ['backdrop_path'],
      genres: List<int>.from(json ['genre_ids']) ,
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

  String getThumbnail() => ApiEndPoints.urlImages + thumbnail;

  String getPoster() => ApiEndPoints.urlImages + poster;
}
