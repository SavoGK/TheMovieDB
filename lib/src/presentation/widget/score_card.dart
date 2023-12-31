import 'package:flutter/material.dart';
import '../../core/utils/general_constants.dart';

class ScoreCard extends StatelessWidget {
  final double score;
  static const double sizeCircumference = 15;
  static const double borderWidth = 4;

  const ScoreCard({
    required this.score,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BordersConst.borderCircular),
        side: const BorderSide(
          width: borderWidth,
          color: Colors.indigo,
        ),
      ),
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(sizeCircumference),
        child: Text(
          '$score',
          style: const TextStyle(fontSize: FontConst.fontTitle),
        ),
      ),
    );
  }
}
