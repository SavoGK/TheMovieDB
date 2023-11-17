import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../../core/utils/general_constants.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../widget/movies_grid.dart';
import '../../domain/entity/genre.dart';
import '../widget/theme_switch_button.dart';

class MoviesGenre extends StatefulWidget {
  final Genre genre;
  final MoviesBloc moviesBloc;
  final CategoriesMovies categories;

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
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        if (snapshot.data is DataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data is DataFailed) {
          return Text('${snapshot.data?.error}');
        } else if (snapshot.data is DataEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(widget.genre.name),
              ),
              actions: const <Widget>[
                ThemeSwitchButton(),
              ],
            ),
            body: const MoviesGrid(
              movies: <Movie>[],
            ),
          );
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
            appBar: AppBar(
              title: Center(
                child: Text(widget.genre.name),
              ),
              actions: const <Widget>[
                ThemeSwitchButton(),
              ],
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
