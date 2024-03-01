import 'package:flutter/material.dart';
import 'package:sportk/model/teams_by_season_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class TeamBubble extends StatelessWidget {
  final TeamBySeasonData team;
  final VoidCallback? onTap;
  final bool selected;

  const TeamBubble({
    super.key,
    required this.team,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomNetworkImage(
            team.imagePath ?? team.logo!,
            height: 100,
            width: 100,
            backgroundColor: context.colorPalette.grey3F1,
            border: selected
                ? Border.all(
                    width: 3,
                    color: context.colorScheme.primary,
                  )
                : null,
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
