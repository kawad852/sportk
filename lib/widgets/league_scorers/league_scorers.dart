import 'package:flutter/material.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/player_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_cell.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_loading.dart';
import 'package:sportk/widgets/league_scorers/penalty.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/team_name.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class LeagueScorers extends StatefulWidget {
  final int leagueId;
  const LeagueScorers({super.key, required this.leagueId});

  @override
  State<LeagueScorers> createState() => _LeagueScorersState();
}

class _LeagueScorersState extends State<LeagueScorers> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;

  Future<TopScorersModel> _initializeFutures(int pageKey) async {
    final seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: widget.leagueId);
    final season = await seasonFuture;
    final topScorersFuture = _footBallProvider.fetchTopScorers(seasonId: season.data!.currentseason!.id!, pageKey: pageKey);
    return topScorersFuture;
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
  }

  @override
  Widget build(BuildContext context) {
    return VexPaginator(
      query: (pageKey) async => _initializeFutures(pageKey),
      onFetching: (snapshot) async => snapshot.data!,
      pageSize: 25,
      onLoading: () {
        return const ShimmerLoading(
          child: LeagueScorersLoading(),
        );
      },
      builder: (context, snapshot) {
        return SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: LeagueScorersCell(text: context.appLocalization.st),
                      ),
                      Expanded(
                        flex: 5,
                        child: LeagueScorersCell(text: context.appLocalization.player),
                      ),
                      Expanded(
                        flex: 2,
                        child: LeagueScorersCell(text: context.appLocalization.goals),
                      ),
                      Expanded(
                        flex: 2,
                        child: LeagueScorersCell(text: context.appLocalization.goalsPenalty),
                      ),
                      Expanded(
                        flex: 2,
                        child: LeagueScorersCell(text: context.appLocalization.missedPenalty),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: snapshot.docs.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                    snapshot.fetchMore();
                    return const VexLoader();
                  }
                  final element = snapshot.docs[index] as TopScoreData;
                  return Padding(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: context.colorPalette.grey3F3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () => context.push(PlayerScreen(playerId: element.player!.id!)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  element.position.toString(),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      element.player!.imagePath!,
                                      width: 35,
                                      height: 35,
                                      shape: BoxShape.circle,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            element.player!.displayName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: context.colorPalette.blueD4B,
                                              fontSize: 12,
                                            ),
                                          ),
                                          TeamName(
                                            teamId: element.participantId,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    element.total.toString(),
                                    style: TextStyle(
                                      color: context.colorPalette.blueD4B,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Penalty(
                                  playerId: element.playerId!,
                                  seasonId: element.seasonId!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
