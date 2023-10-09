import 'package:flutter/material.dart';
import 'package:the_movie_db/models/repository/genre_repository.dart';
import 'package:the_movie_db/views/movies_genre.dart';
import '../models/genre.dart';
import '../models/movie.dart';
import '../utils/general_constants.dart';

class DrawerGenre extends StatelessWidget {
  final List<Movie> movies;

  const DrawerGenre({
    required this.movies,
    super.key,
  });

  static const int mediaQueryConst = 230;
  static const double heightSizeBox = 60;

  List<Movie> getMoviesByGenre(int genreId) {
    return movies.where((movie) => movie.genres.contains(genreId)).toList();
  }

  List<Widget> _getWidget(BuildContext context, List<Genre> genres) {
    var children = <Widget>[];
    children.add(
      const SizedBox(
        height: heightSizeBox,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white24,
          ),
          child: Center(
            child: Text(
              TitleStrings.genders,
              style: TextStyle(
                  fontSize: FontConst.fontTitle,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
    children.addAll(
      genres.map(
        (genre) {
          return ListTile(
            title: Text(
              genre.name,
              style: const TextStyle(
                  fontSize: FontConst.fontTitle,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onTap: () {
              List<Movie> moviesGenre = getMoviesByGenre(genre.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesGenre(
                    genre: genre,
                    movies: moviesGenre,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GenreRepository().getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Genre>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('${FutureConst.error} ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Genre> genres = snapshot.data!;
          return Drawer(
            backgroundColor: Colors.black54,
            width: MediaQuery.of(context).size.width - mediaQueryConst,
            child: ListView(
              children:
                  _getWidget(context, genres),
            ),
          );
        } else {
          return Text('${FutureConst.state} ${snapshot.connectionState}');
        }
      },
    );
  }
}
