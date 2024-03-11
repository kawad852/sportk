import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

class WatchAdButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String points;
  const WatchAdButton({super.key, required this.onPressed, required this.points});

  @override
  Widget build(BuildContext context) {
    return StretchedButton(
      onPressed: onPressed,
      backgroundColor: context.colorPalette.yellowF7A,
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
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    " $points ",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    context.appLocalization.sportk,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const CustomSvg(MyIcons.videoPlay)
          ],
        ),
      ),
    );
  }
}
