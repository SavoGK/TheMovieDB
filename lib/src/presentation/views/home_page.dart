import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../../domain/entity/movie.dart';
import '../bloc/genres_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../widget/movies_grid.dart';
import '../../core/utils/general_constants.dart';
import '../widget/drawer_genre.dart';
import '../widget/theme_switch_button.dart';

class HomePage extends StatefulWidget {
  final MoviesBloc moviesBloc;

  HomePage({
    super.key,
    MoviesBloc? moviesBloc,
  }) : moviesBloc = moviesBloc ?? MoviesBloc();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.moviesBloc.fetchMovies(categories: CategoriesMovies.movie);
  }

  @override
  void dispose() {
    widget.moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return StreamBuilder<DataState>(
      stream: widget.moviesBloc.movies,
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        if (snapshot.data is DataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data is DataFailed) {
          return Text('${snapshot.data?.error}');
        } else if (snapshot.data is DataEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  AppName.name,
                  style: textTheme.displaySmall,
                ),
              ),
              actions: const <Widget>[
                ThemeSwitchButton(),
              ],
            ),
            drawer: DrawerGenre(),
            body: const MoviesGrid(
              movies: <Movie>[],
            ),
          );
        } else {
          List<Movie> movies = <Movie>[];
          if (snapshot.data == null) {
            widget.moviesBloc.fetchMovies(
              categories: CategoriesMovies.movie,
            );
            movies = <Movie>[];
          } else {
            movies = snapshot.data?.data;
          }
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  AppName.name,
                  style: textTheme.displaySmall,
                ),
              ),
              actions: const <Widget>[
                ThemeSwitchButton(),
              ],
            ),
            drawer: DrawerGenre(),
            body: MoviesGrid(
              movies: movies,
            ),
          );
        }
      },
    );
  }
}
