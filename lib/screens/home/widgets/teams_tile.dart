import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sportk/model/schedule_and_results_season_model.dart';
import 'package:sportk/model/season_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/home/widgets/team_widget.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class TeamsTile extends StatefulWidget {
  final String competitionId;

  const TeamsTile({
    super.key,
    required this.competitionId,
  });

  @override
  State<TeamsTile> createState() => _TeamsTileState();
}

class _TeamsTileState extends State<TeamsTile> {
  late FootBallProvider _footBallProvider;
  late Future<List<dynamic>> _futures;

  Future<List<dynamic>> _initializeFutures() async {
    final competitionFuture = _footBallProvider.fetchCompetitions(uuid: widget.competitionId);
    final competitionModel = await competitionFuture;
    final seasonId = competitionModel.results!.first.curSeasonId;
    final seasonFuture = _footBallProvider.fetchSeasons(uuid: seasonId);
    final seasonModel = await seasonFuture;
    // final seasonId = seasonModel.query?.uuid;
    print("seasonId::: $seasonId");
    final scheduleAndResultsSeasonFuture = _footBallProvider.fetchRescheduleAndResultsSeasons(uuid: seasonId);
    return Future.wait([seasonFuture, scheduleAndResultsSeasonFuture]);
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
          _initializeFutures();
        });
      },
      onError: (snapshot) {
        return const SizedBox.shrink();
      },
      onLoading: () {
        return ShimmerLoading(
          child: ListView.separated(
            itemCount: 5,
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
        );
      },
      onComplete: (context, snapshot) {
        final season = snapshot.data![0] as SeasonModel;
        final scheduleAndResultsSeason = snapshot.data![1] as ScheduleAndResultsSeasonModel;
        final list = scheduleAndResultsSeason.results!.take(5).toList();
        return ListView.separated(
          itemCount: list.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 5),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final result = list[index];
            return Container(
              height: 65,
              decoration: BoxDecoration(
                color: context.colorPalette.blue1FC,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  TeamWidget(
                    teamId: result.homeTeamId!,
                    reverse: false,
                  ),
                  const Text("2"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: CircleAvatar(),
                  ),
                  const Text("2"),
                  TeamWidget(
                    teamId: result.awayTeamId!,
                    reverse: true,
                  ),
                  const Spacer(),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: Container(
                      height: 20,
                      width: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: context.colorPalette.red000,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Live",
                        style: context.textTheme.labelSmall!.copyWith(
                          color: context.colorPalette.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
