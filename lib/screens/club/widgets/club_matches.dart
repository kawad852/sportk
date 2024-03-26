import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/widgets/phase_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/match_card.dart';
import 'package:sportk/widgets/match_empty_result.dart';
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
  late CommonProvider _commonProvider;
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
    _commonProvider = context.commonProvider;
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
              ? const MatchEmptyResult()
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
                          return Column(
                            children: [
                              PhaseCard(
                                teamId: widget.teamId,
                                stageId: element.stageId!,
                                leagueId: element.leagueId!,
                                roundId: element.roundId,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  await UiHelper.navigateToMatchInfo(
                                    context,
                                    matchId: element.id!,
                                    leagueId: element.leagueId!,
                                    subType: element.league!.subType!,
                                    commonProvider: _commonProvider,
                                    afterNavigate: () {
                                      setState(() {
                                        _vexKey.currentState!.refresh();
                                      });
                                    },
                                  );
                                },
                                child: MatchCard(element: element),
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
