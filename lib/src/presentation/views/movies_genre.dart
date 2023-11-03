import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../../core/utils/general_constants.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../widget/movies_grid.dart';
import '../../domain/entity/genre.dart';

class MoviesGenre extends StatefulWidget {
  final Genre genre;
  final MoviesBloc moviesBloc;
  final Categories categories;

  const MoviesGenre({
    required this.genre,
    super.key,
    required this.moviesBloc,
    required this.categories,
  });

  @override
  State<MoviesGenre> createState() => _MoviesGenreState();
}

class _MoviesGenreState extends State<MoviesGenre> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.moviesBloc.movies,
      builder: (BuildContext context,
          AsyncSnapshot<DataState> snapshot,) {
        if (snapshot.data is DataLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is DataFailed) {
          return Text('${FutureConst.error} ${snapshot.error}');
        } else {
          List<Movie> movies = <Movie>[];
          if (snapshot.data == null) {
            widget.moviesBloc.fetchMovies(
              categories: widget.categories,
              genre: '${widget.genre.id}',
            );
            movies = <Movie>[];
          } else {
            movies = snapshot.data?.data;
          }
          return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text(widget.genre.name),
            ),
            body: MoviesGrid(
              movies: movies,
            ),
          );
        }
      },
    );
  }
}
