import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/match_timer_circle.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class HomeBubble extends StatefulWidget {
  final DateTime date;
  final int id;
  final String type;
  final List<LiveData> lives;
  final bool isLive;
  final int index;
  final int length;

  const HomeBubble({
    super.key,
    required this.date,
    required this.id,
    required this.lives,
    required this.isLive,
    required this.type,
    required this.index,
    required this.length,
  });

  @override
  State<HomeBubble> createState() => HomeBubbleState();
}

class HomeBubbleState extends State<HomeBubble> with AutomaticKeepAliveClientMixin {
  late Future<LeagueByDateModel> _future;
  late FootBallProvider _footBallProvider;
  late Future<LeagueByDateModel> _teamsFuture;
  late Future<List<dynamic>> _futures;
  late CommonProvider _commonProvider;

  int get _id => widget.id;
  String get _type => widget.type;
  int get _index => widget.index;
  int get _length => widget.length;

  Future<List<dynamic>> _initializeFutures() async {
    late int leagueId;
    late Future<LeagueModel> leagueFuture;
    late Future<LeagueByDateModel> teamsFuture;
    if (_type == CompoTypeEnum.teams) {
      final leagueByTeamFuture = _footBallProvider.fetchLeagueByTeam(context, widget.date, _id);
      final team = await leagueByTeamFuture;
      final id = team.data!.first.leagueId!;
      leagueId = id;
    } else {
      leagueId = _id;
    }
    // if (!mounted) return [];
    leagueFuture = _footBallProvider.fetchLeague(leagueId: leagueId);
    teamsFuture = _footBallProvider.fetchLeagueByDate(widget.date, leagueId);
    return Future.wait([leagueFuture, teamsFuture]);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _commonProvider = context.commonProvider;
    _futures = _initializeFutures();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder(
      future: _futures,
      onRetry: () {
        setState(() {
          _initializeFutures();
        });
      },
      onLoading: () {
        return ShimmerLoading(
          child: Column(
            children: [
              const LoadingBubble(
                height: 50,
                margin: EdgeInsets.only(bottom: 5),
              ),
              ListView.separated(
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 5),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const LoadingBubble(
                    height: 65,
                  );
                },
              ),
            ],
          ),
        );
      },
      onError: (snapshot) {
        print("erorroror::: ${snapshot.error}");
        return const SizedBox.shrink();
      },
      onComplete: (context, snapshot) {
        if (snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }
        final leagueModel = snapshot.data![0] as LeagueModel;
        final matchModel = snapshot.data![1] as LeagueByDateModel;
        List<MatchData> matches = [];
        print("matches::: ${matches.length}");
        if (widget.isLive) {
          final liveMatches = widget.lives.map((e) => e.matchId).toList();
          matches = matchModel.data!.where((element) => liveMatches.contains('${element.id}')).toList();
        } else {
          matches = matchModel.data!;
        }
        if (matches.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            LeagueTile(
              league: leagueModel.data!,
              onTap: () {
                UiHelper.navigateToLeagueInfo(
                  context,
                  leagueData: leagueModel.data!,
                );
              },
            ),
            ListView.separated(
              itemCount: matches.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final match = matches[index];
                final liveMatch = widget.lives.singleWhere((element) => element.matchId == '${match.id}', orElse: () => LiveData());
                int homeGoals = 0;
                int awayGoals = 0;
                int? minute;
                int? timeAdded;
                List<double> goalsTime = [];
                Participant teamHome = Participant();
                Participant teamAway = Participant();
                match.participants!.map((e) {
                  if (e.meta!.location == LocationEnum.home) {
                    teamHome = e;
                  } else {
                    teamAway = e;
                  }
                }).toSet();
                match.periods!.map((period) {
                  if (period.hasTimer! && (period.typeId == 2 || period.typeId == 1)) {
                    minute = period.minutes;
                    timeAdded = period.timeAdded;
                  } else if (period.hasTimer! && period.typeId == 3) {
                    minute = period.minutes;
                    timeAdded = period.timeAdded == null ? 30 : 30 + period.timeAdded!;
                  }
                  period.events!.map((event) {
                    if (event.typeId == 14 || event.typeId == 16) {
                      goalsTime.add(event.minute!.toDouble());
                    }
                  }).toSet();
                }).toSet();
                match.statistics!.map(
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
                return GestureDetector(
                  onTap: () {
                    log(match.id.toString());
                    UiHelper.navigateToMatchInfo(
                      context,
                      matchId: match.id!,
                      leagueId: match.leagueId!,
                      subType: match.league!.subType!,
                      afterNavigate: () {
                        setState(() {
                          _futures = _initializeFutures();
                        });
                      },
                    );
                  },
                  child: Builder(
                    builder: (context) {
                      return Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: context.colorPalette.homeMatchBubble,
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                          border: Border.all(color: context.colorPalette.grey0F5),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                teamHome.name!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            CustomNetworkImage(
                              teamHome.imagePath!,
                              width: 30,
                              height: 30,
                              shape: BoxShape.circle,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  match.state!.id != 1 && match.state!.id != 13 && match.state!.id != 10
                                      ? Text(
                                          "$homeGoals",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox(
                                          width: 6,
                                        ),
                                  match.state!.id == 3
                                      ? Padding(
                                          padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                                          child: MatchTimerCircle(
                                            currentTime: 45,
                                            goalsTime: goalsTime,
                                            timeAdded: 0,
                                            isHalfTime: true,
                                          ),
                                        )
                                      : minute != null
                                          ? Padding(
                                              padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                                              child: MatchTimerCircle(
                                                currentTime: minute!.toDouble(),
                                                goalsTime: goalsTime,
                                                timeAdded: timeAdded,
                                              ),
                                            )
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 55,
                                                  child: Text(
                                                    UiHelper.getMatchState(
                                                      context,
                                                      stateId: match.state!.id!,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: context.colorPalette.green057,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                if (match.state!.id == 1)
                                                  Text(
                                                    DateFormat("HH:mm").format(match.startingAt!),
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                  match.state!.id != 1 && match.state!.id != 13 && match.state!.id != 10
                                      ? Text(
                                          "$awayGoals",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox(
                                          width: 6,
                                        )
                                ],
                              ),
                            ),
                            CustomNetworkImage(
                              teamAway.imagePath!,
                              width: 30,
                              height: 30,
                              shape: BoxShape.circle,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                teamAway.name!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            // if (liveMatch.id != null) LiveBubble(liveData: liveMatch),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            if (_index % 3 == 0)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: GoogleBanner(),
              ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
