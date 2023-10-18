import 'package:flutter/material.dart';
import 'movie_poster.dart';
import '../../core/utils/general_constants.dart';
import '../views/movie_deck.dart';
import '../../data/models/movie.dart';

class MoviesGrid extends StatelessWidget {
  final List<Movie> movies;

  static const String isEmpty = 'There`s not movies of this genre yet';
  static const double gridAspectRatio = 0.6;
  static const int gridAxisCount = 2;

  const MoviesGrid({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => MovieDeck(
                    movie: movie,
                  ),
                ),
              );
            },
            child: MoviePoster(movie: movie),
          );
        }).toList(),
      );
    } else {
      return const Center(
        child: Text(
          isEmpty,
          style: TextStyle(
            color: Colors.white,
            fontSize: FontConst.fontTitle,
          ),
        ),
      );
    }
  }
}
