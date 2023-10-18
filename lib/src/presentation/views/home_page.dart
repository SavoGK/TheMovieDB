import 'package:flutter/material.dart';
import '../widget/movies_grid.dart';
import '../../core/utils/general_constants.dart';
import '../../data/models/movie.dart';
import '../../data/repository/movie_repository.dart';
import '../widget/drawer_genre.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieRepository().getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Movie>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('${FutureConst.error} ${snapshot.error}');
        } else {
          List<Movie> movies = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: const Text(AppName.name),
            ),
            drawer: DrawerGenre(
              movies: movies,
            ),
            body: MoviesGrid(movies: movies)
          );
        }
      },
    );
  }
}
