import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';

class WalletLoading extends StatelessWidget {
  const WalletLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  LoadingBubble(
                    width: 60,
                    height: 60,
                    shape: BoxShape.circle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingBubble(
                        width: 100,
                        height: 20,
                        radius: MyTheme.radiusPrimary,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      LoadingBubble(
                        width: 150,
                        height: 15,
                        radius: MyTheme.radiusPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            LoadingBubble(
              width: 50,
              height: 35,
              radius: MyTheme.radiusSecondary,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
            ),
          ],
        ),
        LoadingBubble(
          width: double.infinity,
          height: 55,
          margin: EdgeInsetsDirectional.only(top: 30, bottom: 10),
        ),
        Row(
          children: [
            Expanded(
              child: LoadingBubble(
                width: double.infinity,
                height: 55,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: LoadingBubble(
                width: double.infinity,
                height: 55,
              ),
            ),
          ],
        ),
        LoadingBubble(
          width: double.infinity,
          height: 54,
          radius: MyTheme.radiusSecondary,
          margin: EdgeInsetsDirectional.only(top: 10, bottom: 2),
        ),
        LoadingBubble(
          width: double.infinity,
          height: 12,
          margin: EdgeInsets.symmetric(horizontal: 20),
          radius: MyTheme.radiusSecondary,
        ),
        LoadingBubble(
          width: double.infinity,
          height: 12,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 3),
          radius: MyTheme.radiusSecondary,
        ),
        SizedBox(
          height: 15,
        ),
        LoadingBubble(
          width: 100,
          height: 20,
          radius: MyTheme.radiusPrimary,
        ),
      ],
    );
  }
}
