import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class ShareAppText extends StatelessWidget {
  const ShareAppText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.appLocalization.shareAppWithFriends,
          style: const TextStyle(
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          context.appLocalization.sportk50,
          style: TextStyle(
            fontSize: 8.5,
            color: context.colorPalette.yellowF7A,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          context.appLocalization.everyRegistration,
          style: const TextStyle(
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
