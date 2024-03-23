import 'package:flutter/material.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/screens/club/club_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/rounded_container.dart';

class TeamCard extends StatelessWidget {
  final Participant team;
  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNetworkImage(
          team.imagePath!,
          width: 70,
          height: 70,
          onTap: () {
            context.push(ClubScreen(teamId: team.id!));
          },
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 5),
          child: SizedBox(
            height: 40,
            child: Text(
              team.name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
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
