import 'package:flutter/material.dart';
import '../../domain/entity/movie.dart';
import '../views/movie_deck.dart';

class MoviePageView extends StatelessWidget {
  final List<Movie> movies;
  final Movie selectedMovie;

  const MoviePageView({
    super.key,
    required this.movies,
    required this.selectedMovie,
  });

  @override
  Widget build(BuildContext context) {
    int initialPage = movies.indexOf(selectedMovie);

    PageController _pageController = PageController(initialPage: initialPage);

    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: movies.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return MovieDeck(
                movie: movies[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
