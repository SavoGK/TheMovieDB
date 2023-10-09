import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../utils/general_constants.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  static const double heightSizeBox = 50;
  static const double widthSizeBox = 200;

  const MoviePoster({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(EdgeInsetsConst.edgeTen),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              movie.getPoster(),
              fit: BoxFit.cover,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          SizedBox(
            height: heightSizeBox,
            width: widthSizeBox,
            child: Center(
              child: Text(
                movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: FontConst.fontSubTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
