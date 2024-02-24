import 'package:flutter/material.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class LeagueLoading extends StatelessWidget {
  const LeagueLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(bottom: 65),
      child: Column(
        children: [
          LoadingBubble(
            width: 100,
            height: 100,
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
