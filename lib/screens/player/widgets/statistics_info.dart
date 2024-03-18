import 'package:flutter/material.dart';
import 'package:sportk/model/country_info_model.dart';
import 'package:sportk/model/player_statistics_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/line_divider.dart';
import 'package:sportk/screens/player/widgets/player_country.dart';
import 'package:sportk/screens/player/widgets/statistics_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class StatisticsInfo extends StatefulWidget {
  final int playerId;
  final int seasonId;
  const StatisticsInfo({super.key, required this.playerId, required this.seasonId});

  @override
  State<StatisticsInfo> createState() => _StatisticsInfoState();
}

class _StatisticsInfoState extends State<StatisticsInfo> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<PlayerStatisticsModel> _playerStatisticsFuture;
  late Future<CountryInfoModel> _countryFuture;
  int _goals = 0, _yellowCard = 0, _redCard = 0, _assist = 0;
  Map<String, int> additionalStatistics = {};

  Future<List<dynamic>> _initializeFutures() async {
    _playerStatisticsFuture = _footBallProvider.fetchPlayerStatistics(
        playerId: widget.playerId, seasonId: widget.seasonId);
    final player = await _playerStatisticsFuture;
    _countryFuture = _footBallProvider.fetchCountry(countryId: player.data!.countryId!);
    return Future.wait([_playerStatisticsFuture, _countryFuture]);
  }

  void statisticsFilters(List<Statistic> statistics) {
    statistics.map(
      (element) {
        element.details!.map((e) {
          switch (e.typeId) {
            case (52):
              _goals = e.value!.total!.toInt();
            case (79):
              _assist = e.value!.total!.toInt();
            case (84):
              _yellowCard = e.value!.total!.toInt();
            case (83):
              _redCard = e.value!.total!.toInt();
            case (41):
              additionalStatistics[context.appLocalization.shotsOffTarget] =
                  e.value!.total!.toInt();
            case (42):
              additionalStatistics[context.appLocalization.shotsTotal] = e.value!.total!.toInt();
            case (86):
              additionalStatistics[context.appLocalization.shotsOnTarget] = e.value!.total!.toInt();
            case (51):
              additionalStatistics[context.appLocalization.offsides] = e.value!.total!.toInt();
            case (56):
              additionalStatistics[context.appLocalization.fouls] = e.value!.total!.toInt();
            case (57):
              additionalStatistics[context.appLocalization.numberSaves] = e.value!.total!.toInt();
            case (78):
              additionalStatistics[context.appLocalization.tackles] = e.value!.total!.toInt();
            case (100):
              additionalStatistics[context.appLocalization.interceptions] = e.value!.total!.toInt();
            case (80):
              additionalStatistics[context.appLocalization.passes] = e.value!.total!.toInt();
            case (81):
              additionalStatistics[context.appLocalization.successfulPasses] =
                  e.value!.total!.toInt();
            case (99):
              additionalStatistics[context.appLocalization.accurateCrosses] =
                  e.value!.total!.toInt();
            case (104):
              additionalStatistics[context.appLocalization.savesInsideBox] =
                  e.value!.total!.toInt();
            case (109):
              additionalStatistics[context.appLocalization.successfulDribbles] =
                  e.value!.total!.toInt();
            case (47):
              additionalStatistics[context.appLocalization.penaltiesScored] =
                  e.value!.scored!.toInt();
              additionalStatistics[context.appLocalization.penaltiesMissed] =
                  e.value!.missed!.toInt();
            case (113):
              additionalStatistics[context.appLocalization.penaltiesSaved] =
                  e.value!.total!.toInt();
            case (119):
              additionalStatistics[context.appLocalization.minutesPlayed] = e.value!.total!.toInt();
            case (122):
              additionalStatistics[context.appLocalization.longBalls] = e.value!.total!.toInt();
            case (124):
              additionalStatistics[context.appLocalization.throughBalls] = e.value!.total!.toInt();
            case (195):
              additionalStatistics[context.appLocalization.cleansheets] = e.value!.total!.toInt();
            case (88):
              additionalStatistics[context.appLocalization.goalsConceded] = e.value!.total!.toInt();
          }
        }).toSet();
      },
    ).toSet();
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
        final statistics = snapshot.data![0] as PlayerStatisticsModel;
        final country = snapshot.data![1] as CountryInfoModel;
        statisticsFilters(statistics.data!.statistics!);
        return Column(
          children: [
            Container(
              height: 128,
              width: double.infinity,
              margin: const EdgeInsetsDirectional.only(end: 15, top: 15),
              decoration: BoxDecoration(
                color: context.colorPalette.grey3F3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatisticsCard(
                      icon: MyIcons.goals,
                      title: context.appLocalization.goals,
                      text: _goals.toString(),
                    ),
                    const LineDivider(),
                    StatisticsCard(
                      icon: MyIcons.yellowCard,
                      title: context.appLocalization.yellowCard,
                      text: _yellowCard.toString(),
                    ),
                    const LineDivider(),
                    StatisticsCard(
                      icon: MyIcons.redCard,
                      title: context.appLocalization.redCard,
                      text: _redCard.toString(),
                    ),
                    const LineDivider(),
                    StatisticsCard(
                      icon: MyIcons.assist,
                      title: context.appLocalization.assist,
                      text: _assist.toString(),
                    ),
                  ],
                ),
              ),
            ),
            PlayerCountry(country: country),
            ListView.separated(
              itemCount: additionalStatistics.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 5),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                String key = additionalStatistics.keys.elementAt(index);
                return additionalStatistics[key] == 0
                    ? null
                    : Container(
                        width: double.infinity,
                        height: 40,
                        margin: const EdgeInsetsDirectional.only(end: 15),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: context.colorPalette.grey3F3,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                key,
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${additionalStatistics[key]}",
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
              },
            )
          ],
        );
      },
    );
  }
}
