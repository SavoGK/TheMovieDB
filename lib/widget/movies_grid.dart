import 'package:flutter/material.dart';
import '../widget/movie_poster.dart';
import '../utils/general_constants.dart';
import '../views/movie_deck.dart';
import '../models/movie.dart';

class MoviesGrid extends StatelessWidget {
  final List<Movie> movies;

  static const String isEmpty = 'There`s not movies of this genre yet';

  const MoviesGrid({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isNotEmpty) {
      return GridView.count(
        childAspectRatio: 0.6,
        crossAxisCount: 2,
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
