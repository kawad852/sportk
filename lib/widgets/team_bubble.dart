import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/screens/club/club_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/favorite_button.dart';

class TeamBubble extends StatelessWidget {
  final TeamInfoData team;
  final bool selected;

  const TeamBubble({
    super.key,
    required this.team,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(ClubScreen(teamId: team.id!));
      },
      child: Column(
        children: [
          CustomNetworkImage(
            team.imagePath ?? team.logo!,
            height: 100,
            width: 100,
            boxFit: BoxFit.scaleDown,
            scale: 2,
            backgroundColor: context.colorPalette.grey3F1,

            // border: selected
            //     ? Border.all(
            //         width: 3,
            //         color: context.colorScheme.primary,
            //       )
            //     : null,
            alignment: AlignmentDirectional.topStart,
            child: FavoriteButton(
              id: team.id!,
              type: CompoTypeEnum.teams,
              name: team.name!,
            ),
          ),
          Text(
            team.name!,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
