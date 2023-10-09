import 'package:flutter/material.dart';
import 'package:the_movie_db/widget/movies_grid.dart';
import '../models/movie.dart';
import '../models/genre.dart';

class MoviesGenre extends StatelessWidget {
  final List<Movie> movies;
  final Genre genre;

  const MoviesGenre({
    required this.genre,
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(genre.name),
      ),
      body: MoviesGrid(movies: movies),
    );
  }
}
