import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/widgets/phase_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/match_card.dart';
import 'package:sportk/widgets/matches_loading.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class ClubMatches extends StatefulWidget {
  final int teamId;
  const ClubMatches({super.key, required this.teamId});

  @override
  State<ClubMatches> createState() => _ClubMatchesState();
}

class _ClubMatchesState extends State<ClubMatches> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<MatchModel> _matchesFuture;
  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<MatchModel> _initializeFuture(int pageKey) {
    _matchesFuture = _footBallProvider.fetchTeamMatchesBetweenTwoDate(
      startDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      endDate: DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 100))),
      teamId: widget.teamId,
      pageKey: pageKey,
    );
    return _matchesFuture;
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _vexKey.currentState!.refresh();
        });
      },
      child: VexPaginator(
        key: _vexKey,
        query: (pageKey) async => _initializeFuture(pageKey),
        onFetching: (snapshot) async => snapshot.data!,
        pageSize: 25,
        onLoading: () {
          return const ShimmerLoading(child: MatchesLoading());
        },
        builder: (context, snapshot) {
          final matches = snapshot.docs as List<MatchData>;
          return matches.isEmpty
              ? Center(
                  child: Text(
                    context.appLocalization.noMatchesAtTheMoment,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.appLocalization.nextMatches,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        itemCount: snapshot.docs.length + 1,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                            snapshot.fetchMore();
                          }

                          if (index == snapshot.docs.length) {
                            return VexLoader(snapshot.isFetchingMore);
                          }

                          final element = matches[index];
                          int homeGoals = 0;
                          int awayGoals = 0;
                          int? minute;
                          element.periods!.map((period) {
                            if (period.hasTimer!) {
                              minute = period.minutes;
                            }
                          }).toSet();
                          element.statistics!.map(
                            (e) {
                              if (e.typeId == 52) {
                                switch (e.location) {
                                  case LocationEnum.home:
                                    homeGoals = e.data!.value!;
                                  case LocationEnum.away:
                                    awayGoals = e.data!.value!;
                                }
                              }
                            },
                          ).toSet();
                          return Column(
                            children: [
                              PhaseCard(
                                teamId: widget.teamId,
                                stageId: element.stageId!,
                                leagueId: element.leagueId!,
                                roundId: element.roundId,
                              ),
                              MatchCard(
                                element: element,
                                awayGoals: awayGoals,
                                homeGoals: homeGoals,
                                minute: minute,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
