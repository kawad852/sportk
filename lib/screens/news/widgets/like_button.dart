import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';

class LikeButton extends StatelessWidget {
  final bool isLike;
  final Function() onPressed;

  const LikeButton({
    super.key,
    required this.isLike,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.authProvider;
    return IconButton(
      onPressed: () {
        authProvider.checkIfUserAuthenticated(
          context,
          callback: () {
            onPressed();
          },
        );
      },
      icon: CustomSvg(
        isLike ? MyIcons.heart : MyIcons.heartEmpty,
        width: 25,
      ),
    );
  }
}
