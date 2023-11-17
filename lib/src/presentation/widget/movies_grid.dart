import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../bloc/genres_bloc.dart';
import '../bloc/movies_bloc.dart';
import 'movie_page_view.dart';
import 'movie_poster.dart';
import '../../core/utils/general_constants.dart';
import '../views/movie_deck.dart';
import '../../domain/entity/movie.dart';

class MoviesGrid extends StatelessWidget {
  final List<Movie> movies;
  final String? genreName;

  static const String isEmpty = 'There`s not movies of this genre yet';
  static const double gridAspectRatio = 0.6;
  static const int gridAxisCount = 2;

  const MoviesGrid({
    this.genreName,
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    if (movies.isNotEmpty) {
      return GridView.count(
        childAspectRatio: gridAspectRatio,
        crossAxisCount: gridAxisCount,
        children: movies.map((movie) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MoviePageView(
                    movies: movies,
                    selectedMovie: movie,
                  ),
                ),
              );
            },
            child: MoviePoster(movie: movie),
          );
        }).toList(),
      );
    } else {
      return Center(
        child: Text(
          isEmpty,
          style: textTheme.titleLarge,
        ),
      );
    }
  }
}
