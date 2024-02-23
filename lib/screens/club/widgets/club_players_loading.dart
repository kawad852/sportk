import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class ClubPlayersLoading extends StatelessWidget {
  const ClubPlayersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            const LoadingBubble(
              width: double.infinity,
              height: 30.0,
              margin: EdgeInsetsDirectional.only(bottom: 5),
              radius: MyTheme.radiusPrimary,
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const LoadingBubble(
                  width: double.infinity,
                  height: 50.0,
                  margin: EdgeInsetsDirectional.only(bottom: 5),
                  radius: MyTheme.radiusSecondary,
                );
              },
            )
          ],
        );
      },
    );
  }
}
