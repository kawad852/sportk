import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class StatisticsLoading extends StatelessWidget {
  const StatisticsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const LoadingBubble(
            width: double.infinity,
            height: 87,
            margin: EdgeInsetsDirectional.only(top: 10),
            radius: MyTheme.radiusSecondary,
          ),
          ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const LoadingBubble(
                width: double.infinity,
                height: 55,
                radius: MyTheme.radiusSecondary,
              );
            },
          )
        ],
      ),
    );
  }
}
