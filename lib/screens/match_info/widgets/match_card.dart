import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/match_info/widgets/final_result.dart';
import 'package:sportk/screens/match_info/widgets/team_card_loading.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/screens/match_info/widgets/team_card.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/match_timer_circle.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class MatchCard extends StatefulWidget {
  final int matchId;
  final int? firstMatchId;
  final int statusMatch;
  final void Function() onTracking;

  const MatchCard({
    super.key,
    required this.matchId,
    required this.statusMatch,
    this.firstMatchId,
    required this.onTracking,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  late FootBallProvider _footBallProvider;
  late Future<SingleMatchModel> _matchFuture;
  Duration difference = const Duration(hours: 0, minutes: 0, seconds: 0);
  void _initializeFuture() {
    _matchFuture = _footBallProvider.fetchMatchById(matchId: widget.matchId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  void showTimer(DateTime date, int state) {
    final utcTime = DateTime.utc(
        date.year, date.month, date.day, date.hour, date.minute, date.second);
    final localTime = utcTime.toLocal();
    difference = localTime.difference(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _matchFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onError: (snapshot) => const SizedBox.shrink(),
      onLoading: () {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ShimmerLoading(
                    child: LoadingBubble(
                      width: 70,
                      height: 70,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  ShimmerLoading(
                    child: LoadingBubble(
                      height: 20,
                      width: 60,
                      padding: EdgeInsetsDirectional.symmetric(
                          vertical: 5, horizontal: 5),
                    ),
                  ),
                  SizedBox(height: 20),
                  ShimmerLoading(child: TeamCardLoading()),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: ShimmerLoading(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingBubble(
                      width: 50,
                      height: 30,
                      margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                      radius: MyTheme.radiusSecondary,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ShimmerLoading(
                    child: LoadingBubble(
                      width: 70,
                      height: 70,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 5),
                  ShimmerLoading(
                    child: LoadingBubble(
                      height: 20,
                      width: 60,
                      padding: EdgeInsetsDirectional.symmetric(
                          vertical: 5, horizontal: 5),
                    ),
                  ),
                  SizedBox(height: 20),
                  ShimmerLoading(child: TeamCardLoading()),
                ],
              ),
            ),
          ],
        );
      },
      onComplete: (context, snapshot) {
        final match = snapshot.data!;
        showTimer(match.data!.startingAt!, match.data!.state!.id!);
        bool showGoals = match.data!.state!.id != 1 &&
            match.data!.state!.id != 13 &&
            match.data!.state!.id != 10 &&
            match.data!.state!.id != 11 &&
            match.data!.state!.id != 12 &&
            match.data!.state!.id != 14 &&
            match.data!.state!.id != 15 &&
            match.data!.state!.id != 16 &&
            match.data!.state!.id != 17 &&
            match.data!.state!.id != 19 &&
            match.data!.state!.id != 20 &&
            match.data!.state!.id != 21 &&
            match.data!.state!.id != 26;
        List<double> goalsTime = [];
        int homeGoals = 0;
        int awayGoals = 0;
        int penaltyGoalsHome = 0;
        int penaltyGoalsAway = 0;
        int? minute;
        int? timeAdded;
        Participant teamHome = Participant();
        Participant teamAway = Participant();
        Future.wait(match.data!.participants!.map((e) async {
          if (e.meta!.location == LocationEnum.home) {
            teamHome = e;
          } else {
            teamAway = e;
          }
        }).toSet());
        match.data!.periods!.map((period) {
          if (period.typeId == 5) {
            period.events!.map((penalty) {
              if (penalty.typeId == 23 &&
                  penalty.participantId == teamHome.id) {
                penaltyGoalsHome += 1;
              }
              if (penalty.typeId == 23 &&
                  penalty.participantId == teamAway.id) {
                penaltyGoalsAway += 1;
              }
            }).toList();
          }
          if (period.hasTimer! && (period.typeId == 2 || period.typeId == 1)) {
            minute = period.minutes;
            timeAdded = period.timeAdded;
          } else if (period.hasTimer! && period.typeId == 3) {
            minute = period.minutes;
            timeAdded = period.timeAdded == null ? 30 : 30 + period.timeAdded!;
          }
          period.events!.map((event) {
            if (event.typeId == 14 ||
                event.typeId == 16 ||
                event.typeId == 15) {
              goalsTime.add(event.minute!.toDouble());
            }
          }).toSet();
        }).toSet();
        match.data!.statistics!.map(
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

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: TeamCard(team: teamHome),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            showGoals ? "$homeGoals" : "",
                            style: TextStyle(
                              color: context.colorPalette.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (penaltyGoalsHome != 0)
                            Text(
                              "($penaltyGoalsHome)",
                              style: TextStyle(
                                color: context.colorPalette.white,
                              ),
                            ),
                        ],
                      ),
                      match.data!.state!.id == 3
                          ? MatchTimerCircle(
                              width: 70,
                              height: 80,
                              currentTime: 45,
                              goalsTime: goalsTime,
                              timeAdded: 0,
                              minuteColor: context.colorPalette.white,
                              fontsize: 19,
                              isHalfTime: true,
                            )
                          : minute != null
                              ? MatchTimerCircle(
                                  width: 70,
                                  height: 80,
                                  currentTime: minute!.toDouble(),
                                  goalsTime: goalsTime,
                                  timeAdded: timeAdded,
                                  minuteColor: context.colorPalette.white,
                                  fontsize: 19,
                                )
                              : match.data!.state!.id == 1
                                  ? Container(
                                      width: 64,
                                      height: 30,
                                      alignment: Alignment.center,
                                      margin:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: context.colorPalette.white
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(
                                            MyTheme.radiusSecondary),
                                      ),
                                      child: Text(
                                        match.data!.startingAt!
                                            .convertToLocal(context),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: context.colorPalette.blueD4B,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 100,
                                      child: Text(
                                        widget.statusMatch == 0
                                            ? context.appLocalization.startSoon
                                            : UiHelper.getMatchState(
                                                context,
                                                stateId: match.data!.state!.id!,
                                              ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: context.colorPalette.white),
                                      ),
                                    ),
                      Column(
                        children: [
                          Text(
                            showGoals ? "$awayGoals" : "",
                            style: TextStyle(
                              color: context.colorPalette.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (penaltyGoalsAway != 0)
                            Text(
                              "($penaltyGoalsAway)",
                              style: TextStyle(
                                color: context.colorPalette.white,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (match.data!.state!.id == 1 ||
                      minute != null ||
                      match.data!.state!.id == 3)
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.statusMatch == 0
                            ? context.appLocalization.startSoon
                            : UiHelper.getMatchState(
                                context,
                                stateId: match.data!.state!.id!,
                              ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: context.colorPalette.white),
                      ),
                    ),
                  if (!difference.isNegative &&
                      match.data!.state!.id == 1 &&
                      difference.inHours <= 24)
                    TweenAnimationBuilder<Duration>(
                      duration: difference,
                      tween: Tween(begin: difference, end: Duration.zero),
                      builder: (BuildContext context, Duration value,
                          Widget? child) {
                        final hours = value.inHours;
                        final minutes = value.inMinutes.remainder(60);
                        final seconds = value.inSeconds.remainder(60);
                        return Text(
                          "$hours:$minutes:$seconds",
                          style: TextStyle(
                            color: context.colorPalette.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.firstMatchId != null)
                    FinalResult(
                      matchId: widget.firstMatchId!,
                      awayGoalsGoing: awayGoals,
                      homeGoalsGoing: homeGoals,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: widget.onTracking,
                    child: Container(
                      height: 25,
                      width: 100,
                      decoration: BoxDecoration(
                        color: context.colorPalette.white.withOpacity(0.6),
                        borderRadius:
                            BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomSvg(MyIcons.liveTracking,
                              fixedColor: true),
                          const SizedBox(width: 3),
                          Text(
                            context.appLocalization.liveTracking,
                            style:
                                TextStyle(color: context.colorPalette.blueD4B),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: TeamCard(team: teamAway),
            ),
          ],
        );
      },
    );
  }
}
