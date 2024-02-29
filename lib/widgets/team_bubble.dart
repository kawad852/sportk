import 'package:flutter/material.dart';
import 'package:sportk/model/matches/our_teams_model.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class TeamBubble extends StatelessWidget {
  final TeamData team;
  final VoidCallback? onTap;
  final BoxBorder? border;

  const TeamBubble({
    super.key,
    required this.team,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomNetworkImage(
            team.logo!,
            height: 100,
            width: 100,
            border: border,
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
