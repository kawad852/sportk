import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/screens/match_info/widgets/team_card.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/match_timer_circle.dart';

class MatchCard extends StatefulWidget {
  final int matchId;
  final int statusMatch;
  const MatchCard({
    super.key,
    required this.matchId,
    required this.statusMatch,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  late FootBallProvider _footBallProvider;
  late Future<SingleMatchModel> _matchFuture;

  void _initializeFuture() {
    _matchFuture = _footBallProvider.fetchMatchById(matchId: widget.matchId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
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
        return Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 60),
          child: Center(
            child: CircularProgressIndicator(
              color: context.colorPalette.blueD4B,
            ),
          ),
        );
      },
      onComplete: (context, snapshot) {
        final match = snapshot.data!;
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
        int? minute;
        int? timeAdded;
        Participant teamHome = Participant();
        Participant teamAway = Participant();
        match.data!.periods!.map((period) {
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
        match.data!.participants!.map((e) {
          if (e.meta!.location == LocationEnum.home) {
            teamHome = e;
          } else {
            teamAway = e;
          }
        }).toSet();
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
                      Text(
                        showGoals ? "$homeGoals" : "",
                        style: TextStyle(
                          color: context.colorPalette.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                              : Container(
                                  width: 64,
                                  height: 30,
                                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                  ),
                                  child: Text(
                                    match.data!.startingAt!.convertToLocal(context),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: context.colorPalette.blueD4B,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                      Text(
                        showGoals ? "$awayGoals" : "",
                        style: TextStyle(
                          color: context.colorPalette.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 64,
                    height: 25,
                    decoration: BoxDecoration(
                      color: context.colorPalette.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorPalette.red000,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          context.appLocalization.live,
                          style: TextStyle(color: context.colorPalette.blueD4B),
                        )
                      ],
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
