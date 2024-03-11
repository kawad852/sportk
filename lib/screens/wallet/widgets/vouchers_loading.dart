import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class VouchersLoading extends StatelessWidget {
  const VouchersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return const LoadingBubble(
          height: 180,
          margin: EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
          radius: MyTheme.radiusSecondary,
        );
      },
    );
  }
}
