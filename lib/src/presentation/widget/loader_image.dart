import 'package:flutter/material.dart';

class LoaderImage extends StatelessWidget {
  final String image;
  final bool forAdults;

  const LoaderImage({
    super.key,
    required this.forAdults,
    required this.image,
  });

  static const double edgeInsetsSymmetric = 50;
  static const double positionedConst = 10;
  static const double scaleImage = 10;
  static const String imageIconAdults = 'images/icon_adults.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          image,
          fit: BoxFit.cover,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return const Padding(
              padding: EdgeInsets.symmetric(
                vertical: edgeInsetsSymmetric,
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        if (forAdults)
          Positioned(
            top: positionedConst,
            right: positionedConst,
            child: Image.asset(
              imageIconAdults,
              scale: scaleImage,
              color: Colors.red,
            ),
          ),
      ],
    );
  }
}
