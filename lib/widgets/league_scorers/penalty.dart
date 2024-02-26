import 'package:flutter/material.dart';
import 'package:sportk/model/player_statistics_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class Penalty extends StatefulWidget {
  final int playerId;
  final int seasonId;
  const Penalty({super.key, required this.playerId, required this.seasonId});

  @override
  State<Penalty> createState() => _PenaltyState();
}

class _PenaltyState extends State<Penalty> {
  late FootBallProvider _footBallProvider;
  late Future<PlayerStatisticsModel> _playerStatisticsFuture;

  void _initializeFuture() {
    _playerStatisticsFuture = _footBallProvider.fetchPlayerStatistics(
      playerId: widget.playerId,
      seasonId: widget.seasonId,
    );
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
      onError: (snapshot) {
        return const SizedBox.shrink();
      },
      onLoading: () {
        return const ShimmerLoading(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LoadingBubble(
                width: 20,
                height: 9,
                radius: 0,
              ),
              SizedBox(
                width: 45,
              ),
              LoadingBubble(
                width: 20,
                height: 9,
                radius: 0,
              ),
            ],
          ),
        );
      },
      onComplete: (context, snapshot) {
        final statistics = snapshot.data!;
        int penaltyGoals = 0;
        int penaltyMissed = 0;
        statistics.data!.statistics!.map(
          (element) {
            element.details!.map((e) {
              if (e.typeId == 47) {
                penaltyGoals = e.value!.scored!.toInt();
                penaltyMissed = e.value!.missed!.toInt();
              }
            }).toSet();
          },
        ).toSet();

        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                penaltyGoals.toString(),
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 40),
              child: Text(
                penaltyMissed.toString(),
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
