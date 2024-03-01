import 'package:flutter/material.dart';
import 'package:sportk/model/teams_by_season_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/team_bubble.dart';

class LeaguesScreen extends StatefulWidget {
  final int leagueId;
  final List<int> selectedTeams;

  const LeaguesScreen({
    super.key,
    required this.leagueId,
    this.selectedTeams = const [],
  });

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  late FootBallProvider _footBallProvider;
  late Future<TeamsBySeasonModel> _teamsFuture;
  late List<int> _selectedTeams;

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
    _selectedTeams = widget.selectedTeams;
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
              final id = team.id!;
              return TeamBubble(
                team: team,
                onTap: () {
                  setState(() {
                    if (_selectedTeams.contains(id)) {
                      _selectedTeams.remove(id);
                    } else {
                      _selectedTeams.add(id);
                    }
                  });
                },
                selected: widget.selectedTeams.contains(id),
              );
            },
          );
        },
      ),
    );
  }
}
