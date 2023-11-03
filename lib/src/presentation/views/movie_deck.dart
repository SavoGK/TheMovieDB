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

class MovieDeck extends StatelessWidget {
  final Movie movie;
  static final GenresBloc genres = GenresBloc();
  static const String description = 'Description';
  static const double sizeFontReleaseDate = 13;

  const MovieDeck({
    required this.movie,
    super.key,
  });

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
    return StreamBuilder(
      stream: genres.genres,
      builder: (
        BuildContext context,
        AsyncSnapshot<DataState> snapshot,
      ) {
        if (snapshot.data is DataLoading){
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data is DataFailed) {
          return Text('${FutureConst.error} ${snapshot.error}');
        } else {
          List<Genre> movieGenres = <Genre>[];
          if (snapshot.data != null) {
            movieGenres = getGenresForMovie(snapshot.data?.data);
          } else {
            genres.fetchGenres();
          }
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text(movie.originalTitle),
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
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: FontConst.fontTitle,
                              ),
                            ),
                            Text(
                              movie.releaseDate,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: sizeFontReleaseDate,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(EdgeInsetsConst.marginSmall),
                        child: Text(
                          TitleStrings.genders,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontConst.fontSubTitle,
                          ),
                        ),
                      ),
                      GenresRow(
                        genres: movieGenres,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(EdgeInsetsConst.marginMedium),
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: FontConst.fontSubTitle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(EdgeInsetsConst.marginMedium),
                    child: Text(
                      movie.overview,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w600,
                        fontSize: FontConst.fontText,
                      ),
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
