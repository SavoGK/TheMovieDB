import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../../domain/entity/movie.dart';
import '../bloc/genres_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../widget/movies_grid.dart';
import '../../core/utils/general_constants.dart';
import '../widget/drawer_genre.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GenresBloc genresBloc = GenresBloc();
  final MoviesBloc moviesBlocByGenre = MoviesBloc();
  final MoviesBloc moviesBlocGeneral = MoviesBloc();

  @override
  void initState() {
    super.initState();
    moviesBlocByGenre.fetchMovies(categories: Categories.movie);
    genresBloc.fetchGenres();
  }

  @override
  void dispose() {
    genresBloc.dispose();
    moviesBlocByGenre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState>(
      stream: moviesBlocByGenre.movies,
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        if (snapshot.data is DataLoading){
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data is DataFailed) {
          return Text('${FutureConst.error} ${snapshot.error}');
        } else {
          List<Movie> movies = <Movie>[];
          if (snapshot.data == null) {
            moviesBlocByGenre.fetchMovies(categories: Categories.movie);
            movies = <Movie>[];
          } else {
            movies = snapshot.data?.data;
          }
          return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: const Text(AppName.name),
            ),
            drawer: const DrawerGenre(),
            body: MoviesGrid(
              movies: movies,
            ),
          );
        }
      },
    );
  }
}
