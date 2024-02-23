import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class PlayerCardLoading extends StatelessWidget {
  const PlayerCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LoadingBubble(
          width: 60,
          height: 60,
          radius: MyTheme.radiusPrimary,
        ),
        const LoadingBubble(
          width: 80,
          height: 15,
          margin: EdgeInsetsDirectional.only(top: 5, bottom: 30),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return const LoadingBubble(
                width: 80,
                height: 50,
                margin: EdgeInsetsDirectional.only(start: 5, end: 5),
                radius: MyTheme.radiusSecondary,
              );
            },
          ),
        )
      ],
    );
  }
}
