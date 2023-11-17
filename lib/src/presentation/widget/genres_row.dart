import 'package:flutter/material.dart';
import '../../core/utils/general_constants.dart';
import '../../domain/entity/genre.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: edgeSymmetric,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: genres
              .map(
                (Genre genre) => Padding(
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
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          spreadRadius: spreadRadius,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(EdgeInsetsConst.marginSmall),
                      child: Text(
                        genre.name,
                        style: textTheme.titleSmall,
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
