import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/match_info/widgets/statistics_loading.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class MatchStatistics extends StatefulWidget {
  final int matchId;
  const MatchStatistics({super.key, required this.matchId});

  @override
  State<MatchStatistics> createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  late FootBallProvider _footBallProvider;
  late Future<SingleMatchModel> _matchFuture;
  Map<String, int> homeStatistics = {};
  Map<String, int> awayStatistics = {};
  int _possessionHome = 0;

  void _initializeFuture() {
    _matchFuture = _footBallProvider.fetchMatchById(matchId: widget.matchId);
  }

  void _initializeStatistics() {
    homeStatistics = {
      context.appLocalization.shotsTotal: 0,
      context.appLocalization.shotsOnTarget: 0,
      context.appLocalization.shotsOffTarget: 0,
      context.appLocalization.passes: 0,
      context.appLocalization.successfulPasses: 0,
      context.appLocalization.accurateCrosses: 0,
      context.appLocalization.goalkeepeSaves: 0,
      context.appLocalization.corners: 0,
      context.appLocalization.offsides: 0,
      context.appLocalization.fouls: 0,
      context.appLocalization.counterAttacks: 0,
    };
    awayStatistics = {
      context.appLocalization.shotsTotal: 0,
      context.appLocalization.shotsOnTarget: 0,
      context.appLocalization.shotsOffTarget: 0,
      context.appLocalization.passes: 0,
      context.appLocalization.successfulPasses: 0,
      context.appLocalization.accurateCrosses: 0,
      context.appLocalization.goalkeepeSaves: 0,
      context.appLocalization.corners: 0,
      context.appLocalization.offsides: 0,
      context.appLocalization.fouls: 0,
      context.appLocalization.counterAttacks: 0,
    };
  }

  void filterStatistics(int typeId, int value, Map<String, int> team) {
    switch (typeId) {
      case 42:
        team[context.appLocalization.shotsTotal] = value;
      case 86:
        team[context.appLocalization.shotsOnTarget] = value;
      case 41:
        team[context.appLocalization.shotsOffTarget] = value;
      case 80:
        team[context.appLocalization.passes] = value;
      case 81:
        team[context.appLocalization.successfulPasses] = value;
      case 99:
        team[context.appLocalization.accurateCrosses] = value;
      case 57:
        team[context.appLocalization.goalkeepeSaves] = value;
      case 34:
        team[context.appLocalization.goalkeepeSaves] = value;
      case 51:
        team[context.appLocalization.offsides] = value;
      case 56:
        team[context.appLocalization.fouls] = value;
      case 1527:
        team[context.appLocalization.counterAttacks] = value;
    }
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
      onLoading: () => const ShimmerLoading(child: StatisticsLoading()),
      onComplete: (context, snapshot) {
        _initializeStatistics();
        final match = snapshot.data!;
        match.data!.statistics!.map(
          (e) {
            if (e.location == LocationEnum.home && e.typeId == 45) {
              _possessionHome = e.data!.value!;
            }
            if (e.location == LocationEnum.home) {
              filterStatistics(e.typeId!, e.data!.value ?? 0, homeStatistics);
            } else if (e.location == LocationEnum.away) {
              filterStatistics(e.typeId!, e.data!.value ?? 0, awayStatistics);
            }
          },
        ).toSet();
        return match.data!.statistics!.isEmpty
            ? NoResults(
                header: const Icon(FontAwesomeIcons.baseball),
                title: context.appLocalization.statisticsNotAvailable,
              )
            : RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _initializeFuture();
                  });
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 87,
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        decoration: BoxDecoration(
                          color: context.colorPalette.grey3F3,
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${_possessionHome == 0 ? "50" : _possessionHome}%",
                              style: TextStyle(
                                color: context.colorPalette.progressGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            CircularPercentIndicator(
                              radius: 39.0,
                              animation: true,
                              animationDuration: 1000,
                              lineWidth: 3.0,
                              reverse: MySharedPreferences.language == LanguageEnum.arabic
                                  ? false
                                  : true,
                              percent: _possessionHome == 0 ? 0.5 : _possessionHome / 100,
                              center: Text(context.appLocalization.possession),
                              backgroundColor: context.colorPalette.progressRed,
                              progressColor: context.colorPalette.progressGreen,
                            ),
                            Text(
                              "${_possessionHome == 0 ? "50" : (100 - _possessionHome)}%",
                              style: TextStyle(
                                color: context.colorPalette.progressRed,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        itemCount: homeStatistics.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String key = homeStatistics.keys.elementAt(index);

                          return Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              color: context.colorPalette.grey3F3,
                              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          homeStatistics[key].toString(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          key,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          awayStatistics[key].toString(),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LinearPercentIndicator(
                                      barRadius: const Radius.circular(MyTheme.radiusSecondary),
                                      width: 145.0,
                                      lineHeight: 8.0,
                                      animation: true,
                                      animationDuration: 1000,
                                      percent: homeStatistics[key] == 0
                                          ? 0
                                          : homeStatistics[key]! /
                                              (homeStatistics[key]! + awayStatistics[key]!),
                                      backgroundColor: context.colorPalette.greyD9D,
                                      progressColor: context.colorPalette.progressGreen,
                                    ),
                                    LinearPercentIndicator(
                                      barRadius: const Radius.circular(MyTheme.radiusSecondary),
                                      width: 145.0,
                                      lineHeight: 8.0,
                                      animation: true,
                                      animationDuration: 1000,
                                      percent: awayStatistics[key] == 0
                                          ? 0
                                          : awayStatistics[key]! /
                                              (homeStatistics[key]! + awayStatistics[key]!),
                                      isRTL: true,
                                      backgroundColor: context.colorPalette.greyD9D,
                                      progressColor: context.colorPalette.progressRed,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
