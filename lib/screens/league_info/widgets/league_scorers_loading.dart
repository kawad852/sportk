import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class LeagueScorersLoading extends StatelessWidget {
  const LeagueScorersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const LoadingBubble(
            width: double.infinity,
            height: 40,
            radius: MyTheme.radiusSecondary,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                child: LoadingBubble(
                  width: double.infinity,
                  height: 50,
                  radius: MyTheme.radiusSecondary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
