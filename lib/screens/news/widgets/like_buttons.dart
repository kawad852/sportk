import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';

class LikeButtons extends StatelessWidget {
  final int? likeType;
  final Function(int? likeType, bool like) onPressed;

  const LikeButtons({
    super.key,
    required this.onPressed,
    required this.likeType,
  });

  bool get _isLike => likeType == LikeType.like;
  bool get _isDisLike => likeType == LikeType.disLike;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.authProvider;
    final commonProvider = context.commonProvider;
    return Row(
      children: [
        IconButton(
          onPressed: () {
            authProvider.checkIfUserAuthenticated(
              context,
              callback: () {
                onPressed(_isLike ? null : 1, true);
              },
            );
          },
          icon: CustomSvg(
            likeType == LikeType.like ? MyIcons.heart : MyIcons.heartEmpty,
            width: 25,
            color: likeType == LikeType.like ? context.colorPalette.red000 : null,
          ),
        ),
        IconButton(
          onPressed: () {
            authProvider.checkIfUserAuthenticated(
              context,
              callback: () {
                onPressed(_isDisLike ? null : 0, false);
              },
            );
          },
          icon: CustomSvg(
            likeType == LikeType.disLike ? MyIcons.dislikeFilled : MyIcons.dislikeOutlined,
            width: 25,
            color: likeType == LikeType.disLike ? context.colorPalette.red000 : null,
          ),
        ),
      ],
    );
  }
}
