import 'package:flutter/material.dart';
import 'genres_row.dart';
import 'score_card.dart';
import 'like_button.dart';
import '../utils/general_constants.dart';
import '../models/movie.dart';

class MovieDeck extends StatelessWidget {
  final Movie movie;
  static const String genres = 'Genres';
  static const String description = 'Description';

  const MovieDeck(
      this.movie, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            Image.asset(
              movie.thumbnail,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(PaddingConstants.rowPadding),
                  child: ScoreCard(
                    score: movie.voteAverage,
                  ),
                ),
                Expanded(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontConstants.fontTitle,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(PaddingConstants.rowPadding),
                  child: Text(
                    genres,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontConstants.fontSubTitle,
                    ),
                  ),
                ),
                GenresRow(
                  genres: movie.genres,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(PaddingConstants.columnPadding),
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: FontConstants.fontSubTitle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PaddingConstants.columnPadding),
              child: Text(
                movie.overview,
                style: const TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                  fontSize: FontConstants.fontText,
                ),
              ),
            ),
            LikeButton(
              like: movie.countLikes,
            ),
          ],
        ),
      ),
    );
  }
}
