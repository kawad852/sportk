import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/rounded_container.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomNetworkImage(
          kFakeImage,
          width: 70,
          height: 70,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
          child: Text(
            "MAN United",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: context.colorPalette.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedContainer(
              color: context.colorPalette.greenAD0,
              text: context.appLocalization.winner,
            ),
            RoundedContainer(
              color: context.colorPalette.yellowFCC,
              text: context.appLocalization.draw,
            ),
            RoundedContainer(
              color: context.colorPalette.red000,
              text: context.appLocalization.loser,
            ),
          ],
        ),
      ],
    );
  }
}
