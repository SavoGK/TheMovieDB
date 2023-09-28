import 'package:flutter/material.dart';
import 'package:the_movie_db/utils/general_constants.dart';

class GenresRow extends StatelessWidget {
  final List<String> genres;
  static const double borderWidth = 3;
  static const double spreadRadius = 1;
  static const double paddingGenres = 4;
  static const double edgeSymmetric = 10;

  const GenresRow({
    required this.genres,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: edgeSymmetric,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: genres
              .map(
                (genre) => Padding(
                  padding: const EdgeInsets.all(paddingGenres),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        BordersConstants.borderCircular,
                      ),
                      border: Border.all(
                        width: borderWidth,
                        color: Colors.indigo,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          spreadRadius: spreadRadius,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(PaddingConstants.rowPadding),
                      child: Text(
                        genre,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: FontConstants.fontText,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
