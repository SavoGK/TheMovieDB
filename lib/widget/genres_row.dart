import 'package:flutter/material.dart';
import '../utils/general_constants.dart';
import '../models/genre.dart';

class GenresRow extends StatelessWidget {
  final List<Genre> genres;
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
                        BordersConst.borderCircular,
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
                          const EdgeInsets.all(EdgeInsetsConst.edgeEight),
                      child: Text(
                        genre.name,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: FontConst.fontText,
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
