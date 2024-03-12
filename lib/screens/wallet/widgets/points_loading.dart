import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class PointsLoading extends StatelessWidget {
  const PointsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 6),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return const LoadingBubble(
          width: double.infinity,
          height: 60,
          radius: MyTheme.radiusSecondary,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          padding: EdgeInsets.symmetric(horizontal: 10),
        );
      },
    );
  }
}
