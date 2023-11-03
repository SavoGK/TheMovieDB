import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../../core/utils/general_constants.dart';
import '../../data/data_source/remote/api_service_movie.dart';
import '../../data/repository/movie_repository.dart';
import '../../domain/entity/movie.dart';
import '../bloc/genres_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../widget/movies_grid.dart';

class MoviesCategory extends StatefulWidget {
  final MoviesBloc moviesBloc;
  final GenresBloc genres;
  final String nameCategory;
  final Categories categories;

  const MoviesCategory({
    super.key,
    required this.moviesBloc,
    required this.genres,
    required this.nameCategory,
    required this.categories,
  });

  @override
  State<MoviesCategory> createState() => _MoviesCategoryState();
}

class _MoviesCategoryState extends State<MoviesCategory> {
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
          return Text('${FutureConst.error} ${snapshot.error}');
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
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text(widget.nameCategory),
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
