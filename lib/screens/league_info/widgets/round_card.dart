import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/stage_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class RoundCard extends StatefulWidget {
  final int leagueId;
  final int roundId;
  const RoundCard({super.key, required this.leagueId, required this.roundId});

  @override
  State<RoundCard> createState() => _RoundCardState();
}

class _RoundCardState extends State<RoundCard> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;
  late Future<StageModel> _roundFuture;

  Future<List<dynamic>> _initializeFutures() async {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: widget.leagueId);
    _roundFuture = _footBallProvider.fetchRound(roundId: widget.roundId);
    return Future.wait([_leagueFuture, _roundFuture]);
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
          radius: MyTheme.radiusPrimary,
        ),
      ),
      onError: (snapshot) => const SizedBox.shrink(),
      onComplete: (context, snapshot) {
        final league = snapshot.data![0] as LeagueModel;
        final round = snapshot.data![1] as StageModel;
        return Container(
          width: double.infinity,
          height: 35,
          margin: const EdgeInsetsDirectional.only(bottom: 10),
          decoration: BoxDecoration(
            color: context.colorPalette.blue4F0,
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
                  "${league.data!.name}-${context.appLocalization.week} ${round.data!.name}",
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
