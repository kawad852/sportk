import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/widgets/stage_card.dart';
import 'package:sportk/screens/match_info/widgets/match_live.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/match_card.dart';
import 'package:sportk/widgets/match_empty_result.dart';
import 'package:sportk/widgets/matches_loading.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class ChampionsMatches extends StatefulWidget {
  final int leagueId;
  final int? matchId;
  const ChampionsMatches({super.key, required this.leagueId, this.matchId});

  @override
  State<ChampionsMatches> createState() => _ChampionsMatchesState();
}

class _ChampionsMatchesState extends State<ChampionsMatches> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<MatchModel> _matchesFuture;
  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<MatchModel> _initializeFuture(int pageKey) {
    _matchesFuture = _footBallProvider.fetchMatchesBetweenTwoDate(
      startDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      endDate: DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 100))),
      leagueId: widget.leagueId,
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
              ? const MatchEmptyResult()
              : SingleChildScrollView(
                  physics:const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(widget.matchId!=null)  MatchLive(matchId: widget.matchId!,margin: const EdgeInsetsDirectional.symmetric(horizontal: 5)),
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
                              if (index == 0 ||
                                  (index > 0 &&
                                      matches[index].stageId != matches[index - 1].stageId))
                                StageCard(stageId: element.stageId!, leagueId: widget.leagueId),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  await UiHelper.navigateToMatchInfo(
                                    context,
                                    matchId: element.id!,
                                    leagueId: element.leagueId!,
                                    subType: element.league!.subType!,
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
