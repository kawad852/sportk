import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueTile extends StatelessWidget {
  final LeagueData league;
  final Widget? trailing;
  final List<int> selectedTeams;
  final VoidCallback onTap;

  const LeagueTile({
    super.key,
    required this.league,
    this.trailing,
    this.selectedTeams = const [],
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      tileColor: context.colorPalette.grey2F2,
      leading: CustomNetworkImage(
        league.logo ?? league.imagePath!,
        radius: 0,
        width: 25,
        height: 25,
      ),
      title: Text(
        league.name!,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
    );
  }
}
