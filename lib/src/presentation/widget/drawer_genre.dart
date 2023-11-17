import 'dart:core';
import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../bloc/genres_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../views/movie_category.dart';
import '../views/movies_genre.dart';
import '../../domain/entity/genre.dart';
import '../../core/utils/general_constants.dart';

class DrawerGenre extends StatefulWidget {
  final GenresBloc genresBloc;

  DrawerGenre({
    super.key,
    GenresBloc? genresBloc,
  }) : genresBloc = genresBloc ?? GenresBloc();

  @override
  State<DrawerGenre> createState() => _DrawerGenreState();
}

class _DrawerGenreState extends State<DrawerGenre> {
  static const int mediaQueryConst = 230;
  static const double heightSizeBox = 200;
  static const double marginCircularProgress = 50;
  static bool showGenres = false;
  static const String nowPlaying = 'NowPlaying';
  static const String popular = 'Popular';
  static const String topRated = 'Top Rated';
  static const String upcoming = 'Upcoming';

  @override
  void initState() {
    widget.genresBloc.fetchGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return StreamBuilder<DataState>(
      stream: widget.genresBloc.genres,
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(marginCircularProgress),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data is DataFailed) {
          return Text('${snapshot.data?.error}');
        } else {
          List<Genre> genres = snapshot.data?.data;
          return Drawer(
            width: MediaQuery.of(context).size.width - mediaQueryConst,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    nowPlaying,
                    style: textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: MoviesBloc(),
                          nameCategory: nowPlaying,
                          categories: CategoriesMovies.nowPlaying,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    popular,
                    style: textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: MoviesBloc(),
                          nameCategory: popular,
                          categories: CategoriesMovies.popular,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    topRated,
                    style: textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: MoviesBloc(),
                          nameCategory: topRated,
                          categories: CategoriesMovies.topRated,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    upcoming,
                    style: textTheme.titleLarge,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: MoviesBloc(),
                          nameCategory: upcoming,
                          categories: CategoriesMovies.upcoming,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    TitleStrings.genders,
                    style: textTheme.titleLarge,
                  ),
                  onTap: () {
                    setState(() {
                      showGenres = !showGenres;
                    });
                  },
                ),
                if (showGenres)
                  SizedBox(
                    height: heightSizeBox,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ...genres.map(
                            (Genre genre) {
                              return ListTile(
                                title: Text(
                                  genre.name,
                                  style: textTheme.titleLarge,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MoviesGenre(
                                        genre: genre,
                                        moviesBloc: MoviesBloc(),
                                        categories: CategoriesMovies.movie,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
