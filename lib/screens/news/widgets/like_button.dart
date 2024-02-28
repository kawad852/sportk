import 'package:flutter/material.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';

class LikeButton extends StatelessWidget {
  final bool isLike;
  final VoidCallback onPressed;

  const LikeButton({
    super.key,
    required this.isLike,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CustomSvg(
        isLike ? MyIcons.heart : MyIcons.heartEmpty,
        width: 25,
      ),
    );
  }
}
