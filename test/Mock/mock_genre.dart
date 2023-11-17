import 'package:the_movie_db/src/data/models/genre_model.dart';

class MockGenre {
  static final GenreModel genre = GenreModel(
    id: 0,
    name: 'genre',
  );
  static final GenreModel genre2 = GenreModel(
    id: 1,
    name: 'genre2',
  );
  static final List<GenreModel> genres = <GenreModel>[
    genre,
    genre2,
  ];

  static const String urlGenres =
      'https://api.themoviedb.org/3/genre/movie/list';
}
