import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../../core/utils/general_constants.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../widget/movies_grid.dart';
import '../widget/theme_switch_button.dart';

class MoviesCategory extends StatefulWidget {
  final MoviesBloc moviesBloc;
  final String nameCategory;
  final CategoriesMovies categories;

  const MoviesCategory({
    super.key,
    required this.moviesBloc,
    required this.nameCategory,
    required this.categories,
  });

  @override
  State<MoviesCategory> createState() => _MoviesCategoryState();
}

class _MoviesCategoryState extends State<MoviesCategory> {
  @override
  void initState() {
    super.initState();
    widget.moviesBloc.fetchMovies(categories: widget.categories);
  }

  @override
  void dispose() {
    widget.moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.moviesBloc.movies,
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        if (snapshot.data is DataLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data is DataFailed) {
          return Text('${snapshot.data?.error}');
        } else {
          List<Movie> movies = <Movie>[];
          if (snapshot.data == null) {
            widget.moviesBloc.fetchMovies(
              categories: widget.categories,
            );
            movies = <Movie>[];
          } else {
            movies = snapshot.data?.data;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.nameCategory),
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
