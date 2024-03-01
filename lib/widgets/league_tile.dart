import 'package:flutter/material.dart';
import 'package:sportk/model/matches/our_league_model.dart';
import 'package:sportk/screens/wizard/leagues_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueTile extends StatelessWidget {
  final OurLeagueData league;
  final Widget trailing;
  final List<int> selectedTeams;
  final Function(dynamic value)? onBack;

  const LeagueTile({
    super.key,
    required this.league,
    required this.trailing,
    this.selectedTeams = const [],
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context
            .push(
          LeaguesScreen(
            leagueId: league.id!,
            selectedTeams: selectedTeams,
          ),
        )
            .then((value) {
          onBack!(value);
        });
      },
      dense: true,
      tileColor: context.colorPalette.grey2F2,
      leading: CustomNetworkImage(
        league.logo!,
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
