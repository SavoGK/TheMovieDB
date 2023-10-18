import 'package:flutter/material.dart';
import '../widget/movies_grid.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/genre.dart';

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
