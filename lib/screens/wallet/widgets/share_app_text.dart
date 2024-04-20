import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class ShareAppText extends StatelessWidget {
  final String points;
  const ShareAppText({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.appLocalization.shareAppWithFriends,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              " $points ${context.appLocalization.point}",
              style: TextStyle(
                fontSize: 13,
                color: context.colorPalette.yellowF7A,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          context.appLocalization.everyRegistration,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
