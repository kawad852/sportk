import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/teams_by_season_model.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/team_bubble.dart';

class LeagueTeamsScreen extends StatefulWidget {
  final int leagueId;
  final String leagueName;

  const LeagueTeamsScreen({
    super.key,
    required this.leagueId,
    required this.leagueName,
  });

  @override
  State<LeagueTeamsScreen> createState() => _LeagueTeamsScreenState();
}

class _LeagueTeamsScreenState extends State<LeagueTeamsScreen> {
  late FootBallProvider _footBallProvider;
  late FavoriteProvider _favoriteProvider;
  late Future<TeamsBySeasonModel> _teamsFuture;

  Future<TeamsBySeasonModel> _initializeLeagues() async {
    final seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: widget.leagueId);
    final season = await seasonFuture;
    final teamsFuture = _footBallProvider.fetchTeamsBySeason(seasonId: season.data!.id!);
    return teamsFuture;
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _favoriteProvider = context.favoriteProvider;
    _teamsFuture = _initializeLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.leagueName),
      ),
      body: CustomFutureBuilder(
        future: _teamsFuture,
        onRetry: () {
          setState(() {
            _teamsFuture = _initializeLeagues();
          });
        },
        onComplete: (context, snapshot) {
          return Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
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
                  final id = team.id!;
                  return TeamBubble(
                    team: team,
                    selected: _favoriteProvider.isFav(id, CompoTypeEnum.teams),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
