import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class MatchesLoading extends StatelessWidget {
  const MatchesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingBubble(
            width: 100,
            height: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return const Column(
                children: [
                  LoadingBubble(
                    width: double.infinity,
                    height: 35,
                    margin: EdgeInsetsDirectional.only(bottom: 10),
                    radius: MyTheme.radiusPrimary,
                  ),
                  LoadingBubble(
                    width: double.infinity,
                    height: 55,
                    margin: EdgeInsetsDirectional.only(bottom: 10),
                    radius: MyTheme.radiusPrimary,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
