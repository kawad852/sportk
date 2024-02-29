import 'package:flutter/material.dart';
import 'package:sportk/model/teams_by_season_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/team_bubble.dart';

class LeaguesScreen extends StatefulWidget {
  final String leagueId;

  const LeaguesScreen({
    super.key,
    required this.leagueId,
  });

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  late FootBallProvider _footBallProvider;
  late Future<TeamsBySeasonModel> _teamsFuture;

  Future<TeamsBySeasonModel> _initializeLeagues() async {
    final seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: int.parse(widget.leagueId));
    final season = await seasonFuture;
    final teamsFuture = _footBallProvider.fetchTeamsBySeason(seasonId: season.data!.id!);
    return teamsFuture;
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _teamsFuture = _initializeLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("League"),
      ),
      body: CustomFutureBuilder(
          future: _teamsFuture,
          onRetry: () {
            setState(() {
              _teamsFuture = _initializeLeagues();
            });
          },
          onComplete: (context, snapshot) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.data!.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final team = snapshot.data!.data![index];
                return TeamBubble(team: team);
              },
            );
          }),
    );
  }
}
