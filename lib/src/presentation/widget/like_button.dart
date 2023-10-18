import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  int like;

  LikeButton({
    required this.like,
    super.key,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool wasPress = false;

  _LikeButtonState();

  void toggleLike() {
    if (wasPress) {
      widget.like--;
    } else {
      widget.like++;
    }
    wasPress = !wasPress;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        toggleLike();
      },
      icon: const Icon(
        Icons.thumb_up_outlined,
        color: Colors.black,
      ),
      label: Text('${widget.like}'),
    );
  }
}
