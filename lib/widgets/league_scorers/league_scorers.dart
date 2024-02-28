import 'package:flutter/material.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_cell.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_loading.dart';
import 'package:sportk/widgets/league_scorers/scorers_card.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class LeagueScorers extends StatefulWidget {
  final int leagueId;
  const LeagueScorers({super.key, required this.leagueId});

  @override
  State<LeagueScorers> createState() => _LeagueScorersState();
}

class _LeagueScorersState extends State<LeagueScorers> {
  late FootBallProvider _footBallProvider;

  Future<TopScorersModel> _initializeFutures(int pageKey) async {
    final seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: widget.leagueId);
    final season = await seasonFuture;
    final topScorersFuture = _footBallProvider.fetchTopScorers(
        seasonId: season.data!.currentseason!.id!, pageKey: pageKey);
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
                  return ScorersCard(
                    topScoreData: element,
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
