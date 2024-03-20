import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_svg.dart';

class WatchAdButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String points;
  const WatchAdButton({super.key, required this.onPressed, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.adButtonColor,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      margin: const EdgeInsetsDirectional.only(top: 30, bottom: 10),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.appLocalization.watchAd,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colorPalette.white,
                    ),
                  ),
                  Text(
                    " $points ",
                    style: TextStyle(
                      color: context.colorPalette.videoPlayColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    context.appLocalization.sportk,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colorPalette.white,
                    ),
                  ),
                ],
              ),
            ),
            CustomSvg(
              MyIcons.videoPlay,
              color: context.colorPalette.videoPlayColor,
            ),
          ],
        ),
      ),
    );
  }
}
