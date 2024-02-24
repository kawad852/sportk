import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/stage_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class StageCard extends StatefulWidget {
  final int stageId;
  const StageCard({super.key, required this.stageId});

  @override
  State<StageCard> createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;
  late Future<StageModel> _stageFuture;

  Future<List<dynamic>> _initializeFutures() async {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: 2);
    _stageFuture = _footBallProvider.fetchStage(stageId: widget.stageId);
    return Future.wait([_leagueFuture, _stageFuture]);
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
        setState(
          () {
            _futures = _initializeFutures();
          },
        );
      },
      onLoading: () => const ShimmerLoading(
        child: LoadingBubble(
          width: double.infinity,
          height: 35,
          margin: EdgeInsetsDirectional.only(bottom: 10),
        ),
      ),
      onError: (snapshot) => const SizedBox.shrink(),
      onComplete: (context, snapshot) {
        final league = snapshot.data![0] as LeagueModel;
        final stage = snapshot.data![1] as StageModel;
        return Container(
          width: double.infinity,
          height: 35,
          margin: const EdgeInsetsDirectional.only(bottom: 10),
          decoration: BoxDecoration(
            color: context.colorPalette.greyEAE,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8, end: 5),
                child: CustomNetworkImage(
                  league.data!.imagePath!,
                  width: 20,
                  height: 20,
                ),
              ),
              Flexible(
                child: Text(
                  "${league.data!.name}-${stage.data!.name}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
