import 'package:flutter/material.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/model/season_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/league_card.dart';
import 'package:sportk/screens/player/widgets/statistics_info.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class PlayerStatistics extends StatefulWidget {
  final int playerId;
  const PlayerStatistics({super.key, required this.playerId});

  @override
  State<PlayerStatistics> createState() => _PlayerStatisticsState();
}

class _PlayerStatisticsState extends State<PlayerStatistics> {
  int _selectedIndex = 0;
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<PlayerModel> _playerFuture;
  late Future<SeasonInfoModel> _seasonByTeam1Future;
  late Future<SeasonInfoModel> _seasonByTeam2Future;
  final List<int> _leagueIds = [];
  final List<int> _seasonIds = [];

  Future<List<dynamic>> _initializeFutures() async {
    _playerFuture = _footBallProvider.fetchPlayerInfo(playerId: widget.playerId);
    final team = await _playerFuture;
    if (team.data != null) {
      if (team.data!.teams!.isNotEmpty) {
        _seasonByTeam1Future =
            _footBallProvider.fetchSeasonsByTeam(teamId: team.data!.teams![0].teamId!);
        final season = await _seasonByTeam1Future;
        if (season.data!.isNotEmpty) {
          season.data!.map((e) {
            if (e.isCurrent == true) {
              _leagueIds.add(e.leagueId!);
              _seasonIds.add(e.id!);
            }
          }).toSet();
        }
      }
      if (team.data!.teams!.length > 1) {
        _seasonByTeam2Future =
            _footBallProvider.fetchSeasonsByTeam(teamId: team.data!.teams![1].teamId!);
        final season = await _seasonByTeam2Future;
        if (season.data!.isNotEmpty) {
          season.data!.map((e) {
            if (e.isCurrent == true) {
              _leagueIds.add(e.leagueId!);
              _seasonIds.add(e.id!);
            }
          }).toSet();
        }
      }
    }
    return Future.wait([
      _playerFuture,
    ]);
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
        setState(() {
          _futures = _initializeFutures();
        });
      },
      onLoading: () {
        return Padding(
          padding: const EdgeInsetsDirectional.only(top: 50),
          child: Center(
            child: CircularProgressIndicator(
              color: context.colorPalette.blueD4B,
            ),
          ),
        );
      },
      onComplete: (context, snapshot) {
        final player = snapshot.data![0] as PlayerModel;
        return player.data == null
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.appLocalization.statistics,
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _leagueIds.isEmpty
                        ? Text(context.appLocalization.noStatistics)
                        : SizedBox(
                            height: 35.0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _leagueIds.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: LeagueCard(
                                    leagueId: _leagueIds[index],
                                    index: index,
                                    selectIndex: _selectedIndex,
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  _leagueIds.isEmpty
                      ? const SizedBox.shrink()
                      : StatisticsInfo(
                          key: UniqueKey(),
                          playerId: widget.playerId,
                          seasonId: _seasonIds[_selectedIndex],
                        ),
                ],
              );
      },
    );
  }
}
