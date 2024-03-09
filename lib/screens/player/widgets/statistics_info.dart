import 'package:flutter/material.dart';
import 'package:sportk/model/country_info_model.dart';
import 'package:sportk/model/player_statistics_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/line_divider.dart';
import 'package:sportk/screens/player/widgets/statistics_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

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

  Future<List<dynamic>> _initializeFutures() async {
    _playerStatisticsFuture = _footBallProvider.fetchPlayerStatistics(
        playerId: widget.playerId, seasonId: widget.seasonId);
    final player = await _playerStatisticsFuture;
    _countryFuture = _footBallProvider.fetchCountry(countryId: player.data!.countryId!);
    return Future.wait([_playerStatisticsFuture, _countryFuture]);
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
        int goals = 0;
        int yellowCard = 0;
        int redCard = 0;
        int assist = 0;
        statistics.data!.statistics!.map(
          (element) {
            element.details!.map((e) {
              switch (e.typeId) {
                case (52):
                  goals = e.value!.total!.toInt();
                case (79):
                  assist = e.value!.total!.toInt();
                case (84):
                  yellowCard = e.value!.total!.toInt();
                case (83):
                  redCard = e.value!.total!.toInt();
              }
            }).toSet();
          },
        ).toSet();
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
                      text: goals.toString(),
                    ),
                    const LineDivider(),
                    StatisticsCard(
                      icon: MyIcons.yellowCard,
                      title: context.appLocalization.yellowCard,
                      text: yellowCard.toString(),
                    ),
                    const LineDivider(),
                    StatisticsCard(
                      icon: MyIcons.redCard,
                      title: context.appLocalization.redCard,
                      text: redCard.toString(),
                    ),
                    const LineDivider(),
                    StatisticsCard(
                      icon: MyIcons.assist,
                      title: context.appLocalization.assist,
                      text: assist.toString(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsetsDirectional.only(end: 15, top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: context.colorPalette.grey3F3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    context.appLocalization.playerNationality,
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      CustomNetworkImage(
                        country.data!.imagePath!,
                        width: 20,
                        height: 20,
                        shape: BoxShape.circle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          country.data!.name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: context.colorPalette.blueD4B,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
