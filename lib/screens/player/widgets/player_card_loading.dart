import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class PlayerCardLoading extends StatelessWidget {
  const PlayerCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LoadingBubble(
          width: 60,
          height: 60,
          shape: BoxShape.circle,
        ),
        LoadingBubble(
          width: 80,
          height: 15,
          margin: EdgeInsetsDirectional.only(top: 5, bottom: 30),
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingBubble(
                width: 80,
                height: 50,
                radius: MyTheme.radiusSecondary,
              ),
              LoadingBubble(
                width: 80,
                height: 50,
                radius: MyTheme.radiusSecondary,
              ),
              LoadingBubble(
                width: 80,
                height: 50,
                radius: MyTheme.radiusSecondary,
              ),
              LoadingBubble(
                width: 80,
                height: 50,
                radius: MyTheme.radiusSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
