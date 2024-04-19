import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class TeamCardLoading extends StatelessWidget {
  const TeamCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return const LoadingBubble(
            width: 20,
            height: 20,
            margin: EdgeInsetsDirectional.only(end: 5),
            radius: MyTheme.radiusPrimary,
          );
        },
      ),
    );
  }
}
