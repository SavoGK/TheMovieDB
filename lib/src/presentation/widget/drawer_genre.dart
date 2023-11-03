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

  const DrawerGenre({super.key});

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
  static final MoviesBloc moviesCategoryBloc = MoviesBloc();
  static final GenresBloc genresBloc = GenresBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState>(
      stream: genresBloc.genres,
      builder: (BuildContext context, AsyncSnapshot<DataState> snapshot) {
        if (snapshot.data == null) {
          genresBloc.fetchGenres();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(marginCircularProgress),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data is DataFailed) {
          return Text('${snapshot.data?.error}');
        } else if (snapshot.data is DataSuccess) {
          List<Genre> genres = snapshot.data?.data;
          return Drawer(
            backgroundColor: Colors.black54,
            width: MediaQuery.of(context).size.width - mediaQueryConst,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text(
                    nowPlaying,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontConst.fontTitle,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: MoviesBloc(),
                          genres: genresBloc,
                          nameCategory: nowPlaying,
                          categories: Categories.nowPlaying,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    popular,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontConst.fontTitle,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: moviesCategoryBloc,
                          genres: genresBloc,
                          nameCategory: popular,
                          categories: Categories.popular,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    topRated,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontConst.fontTitle,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: moviesCategoryBloc,
                          genres: genresBloc,
                          nameCategory: topRated,
                          categories: Categories.topRated,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    upcoming,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontConst.fontTitle,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MoviesCategory(
                          moviesBloc: moviesCategoryBloc,
                          genres: genresBloc,
                          nameCategory: upcoming,
                          categories: Categories.upcoming,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    TitleStrings.genders,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontConst.fontTitle,
                    ),
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
                                  style: const TextStyle(
                                    fontSize: FontConst.fontTitle,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MoviesGenre(
                                        genre: genre,
                                        moviesBloc: moviesCategoryBloc,
                                        categories: Categories.movie,
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
        } else {
          return Text('${FutureConst.state} ${snapshot.connectionState}');
        }
      },
    );
  }
}
