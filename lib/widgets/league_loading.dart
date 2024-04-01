import 'package:flutter/material.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class LeagueLoading extends StatelessWidget {
  const LeagueLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LoadingBubble(
            width: 125,
            height: 125,
            shape: BoxShape.circle,
          ),
          SizedBox(
            height: 10,
          ),
          LoadingBubble(
            width: 50,
            height: 20,
            radius: 20,
          ),
        ],
      ),
    );
  }
}
