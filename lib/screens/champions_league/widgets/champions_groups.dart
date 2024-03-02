import 'package:flutter/material.dart';
import 'package:sportk/model/champions_groups_model.dart';
import 'package:sportk/model/season_by_league_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/widgets/groups_standings.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class ChampionsGroups extends StatefulWidget {
  final int? teamId;
  final int leagueId;
  const ChampionsGroups({super.key, this.teamId, required this.leagueId});

  @override
  State<ChampionsGroups> createState() => _ChampionsGroupsState();
}

class _ChampionsGroupsState extends State<ChampionsGroups> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<SeasonByLeagueModel> _seasonFuture;
  late Future<ChampionsGroupsModel> _groupsFuture;
  final Set<int> _groups = {};
  late int _seasonId;

  Future<List<dynamic>> _initializeFutures() async {
    _seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: widget.leagueId);
    final season = await _seasonFuture;
    _seasonId = season.data!.currentseason!.id!;
    _groupsFuture = _footBallProvider.fetchChampionsGroup(seasonId: _seasonId);
    final group = await _groupsFuture;
    return Future.wait(group.data!.map((element) async {
      _groups.add(element.group!.id!);
    }).toSet());
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _futures = _initializeFutures();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _futures,
      onRetry: () {
        setState(
          () {
            _futures = _initializeFutures();
          },
        );
      },
      onComplete: (context, snapshot) {
        return _groups.isEmpty
            ? Center(
                child: Text("لا يوجد معلومات متوفرة عن المجموعات في الوقت الحالي"),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _groups.length,
                itemBuilder: (BuildContext context, int index) {
                  return GroupsStandings(
                    groupId: _groups.elementAt(index),
                    seasonId: _seasonId,
                    teamId: widget.teamId,
                  );
                },
              );
      },
    );
  }
}
