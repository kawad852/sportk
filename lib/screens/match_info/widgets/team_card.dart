import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/rounded_container.dart';

class TeamCard extends StatelessWidget {
  final String team;
  const TeamCard({super.key, required this.team});

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
          padding: const EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 5),
          child: SizedBox(
            height: 40,
            child: Text(
              team,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: context.colorPalette.white),
            ),
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
