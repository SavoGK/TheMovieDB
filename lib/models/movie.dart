class Movie {
  final String title;
  final String originalTitle;
  final String thumbnail;
  final String poster;
  final String overview;
  final double voteAverage;
  final List<String> genres;
  int countLikes;

  Movie({
    required this.title,
    required this.originalTitle,
    required this.thumbnail,
    required this.poster,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.countLikes,
  });

  factory Movie.mockMovie() => Movie(
    title: 'The Super Mario Bros. Movie',
    originalTitle: 'The Super Mario Bros. Movie',
    thumbnail: 'images/backdrop_mario_bros_movie.jpg',
    poster: 'images/poster_mario_bros_movie.jpg',
    overview: 'While working underground to fix a water main, Brooklyn '
        'plumbers—and brothers—Mario and Luigi are transported down a '
        'mysterious pipe and wander into a magical new world. But when the '
        'brothers are separated, Mario embarks on an epic quest to find '
        'Luigi.',
    voteAverage: 7.8,
    genres: ['Animation', 'Family', 'Adventure', 'Fantasy', 'Comedy'],
    countLikes: 5,
  );
}
