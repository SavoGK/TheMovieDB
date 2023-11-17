import 'package:flutter/material.dart';
import '../../core/utils/data_state.dart';
import '../bloc/genres_bloc.dart';
import '../widget/loader_image.dart';
import '../widget/genres_row.dart';
import '../../domain/entity/genre.dart';
import '../widget/score_card.dart';
import '../widget/like_button.dart';
import '../../core/utils/general_constants.dart';
import '../../domain/entity/movie.dart';
import '../widget/theme_switch_button.dart';

class MovieDeck extends StatelessWidget {
  final Movie movie;
  final GenresBloc genres;
  static const String description = 'Description';
  static const double sizeFontReleaseDate = 13;

  MovieDeck({
    required this.movie,
    GenresBloc? genresBloc,
    super.key,
  }) : genres = genresBloc ?? GenresBloc();

  List<Genre> getGenresForMovie(
    List<Genre> genres,
  ) {
    return genres.where(
      (Genre genre) {
        return movie.genres.contains(genre.id);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return StreamBuilder(
      stream: genres.genres,
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        genres.fetchGenres();
        if (snapshot.data is DataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data is DataFailed) {
          return Text('${snapshot.data?.error}');
        } else {
          List<Genre> movieGenres = <Genre>[];
          if (snapshot.data is DataSuccess) {
            if (snapshot.data != null) {
              movieGenres = getGenresForMovie(snapshot.data?.data);
            } else {
              genres.fetchGenres();
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  movie.title,
                  style: textTheme.titleLarge,
                ),
              ),
              actions: const <Widget>[
                ThemeSwitchButton(),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  LoaderImage(
                    forAdults: movie.adult,
                    image: movie.getThumbnail(),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.all(EdgeInsetsConst.marginSmall),
                        child: ScoreCard(
                          score: movie.voteAverage,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movie.title,
                              style: textTheme.titleLarge,
                            ),
                            Text(
                              movie.releaseDate,
                              style: textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.all(EdgeInsetsConst.marginSmall),
                        child: Text(
                          TitleStrings.genders,
                          style: textTheme.titleMedium,
                        ),
                      ),
                      GenresRow(
                        genres: movieGenres,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(EdgeInsetsConst.marginMedium),
                    child: Text(
                      description,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(EdgeInsetsConst.marginMedium),
                    child: Text(
                      movie.overview,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  LikeButton(
                    like: movie.voteCount,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
