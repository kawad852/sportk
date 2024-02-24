import 'package:flutter/material.dart';
import 'package:sportk/model/player_statistics_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/line_divider.dart';
import 'package:sportk/screens/player/widgets/statistics_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class StatisticsInfo extends StatefulWidget {
  final int playerId;
  final int seasonId;
  const StatisticsInfo({super.key, required this.playerId, required this.seasonId});

  @override
  State<StatisticsInfo> createState() => _StatisticsInfoState();
}

class _StatisticsInfoState extends State<StatisticsInfo> {
  late FootBallProvider _footBallProvider;
  late Future<PlayerStatisticsModel> _playerStatisticsFuture;

  void _initializeFuture() {
    _playerStatisticsFuture = _footBallProvider.fetchPlayerStatistics(
        playerId: widget.playerId, seasonId: widget.seasonId);
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
      future: _playerStatisticsFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
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
      // onLoading: () {
      //   return Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       CircularProgressIndicator(
      //         color: context.colorPalette.blueD4B,
      //       ),
      //     ],
      //   );
      //   // const ShimmerLoading(
      //   //   child: Padding(
      //   //     padding: EdgeInsetsDirectional.only(end: 15, top: 15, start: 8),
      //   //     child: LoadingBubble(
      //   //       height: 128,
      //   //       width: double.infinity,
      //   //       radius: MyTheme.radiusSecondary,
      //   //     ),
      //   //   ),
      //   // );
      // },
      onComplete: (context, snapshot) {
        final statistics = snapshot.data!;
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
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 15, top: 15),
          child: Container(
            height: 128,
            width: double.infinity,
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
        );
      },
    );
  }
}
