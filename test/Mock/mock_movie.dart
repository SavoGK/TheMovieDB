import 'package:the_movie_db/src/domain/entity/movie.dart';

class MockMovies {
  static final Movie mockMovie = Movie(
    adult: false,
    thumbnail: '/1syW9SNna38rSl9fnXwc9fP7POW.jpg',
    genres: <int>[28, 878, 12],
    idMovie: 565770,
    originalLanguage: 'en',
    originalTitle: 'Blue Beetle',
    overview: 'Recent college grad Jaime Reyes returns home '
        'full of aspirations for his future,'
        'only to find that home is not quite as he left it. '
        'As he searches to find his purpose in the world,'
        'fate intervenes when Jaime unexpectedly finds '
        'himself in possession of an ancient relic of alien biotechnology:'
        'the Scarab.',
    popularity: 2972.534,
    poster: '/mXLOHHc1Zeuwsl4xYKjKh2280oL.jpg',
    releaseDate: '2023-08-16',
    title: 'Blue Beetle',
    video: false,
    voteAverage: 7.2,
    voteCount: 956,
  );

  static final List<Movie> mockMoviesList = <Movie>[
    mockMovie,
  ];

  static const String isEmpty = 'There`s not movies of this genre yet';
}

class ResultException {
  static final Exception exception = Exception('exception');
}

class Parameters {
  static const Map<String, dynamic> params = <String, dynamic>{
    'page': 1,
  };
}
