import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/stage_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class PhaseCard extends StatefulWidget {
  final int leagueId;
  final int stageId;
  final int teamId;
  final int? roundId;

  const PhaseCard({
    super.key,
    required this.leagueId,
    required this.stageId,
    required this.teamId,
    this.roundId,
  });

  @override
  State<PhaseCard> createState() => _PhaseCardState();
}

class _PhaseCardState extends State<PhaseCard> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;
  late Future<StageModel> _phaseFuture;

  Future<List<dynamic>> _initializeFutures() async {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: widget.leagueId);
    _phaseFuture = widget.roundId != null
        ? _footBallProvider.fetchRound(roundId: widget.roundId!)
        : _footBallProvider.fetchStage(stageId: widget.stageId);

    return Future.wait([_leagueFuture, _phaseFuture]);
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
        final phase = snapshot.data![1] as StageModel;

        return InkWell(
          onTap: () {
            league.data!.subType == LeagueTypeEnum.cubInternational
                ? context.push(
                    ChampionsLeagueScreen(
                      leagueId: widget.leagueId,
                      teamId: widget.teamId,
                    ),
                  )
                : context.push(
                    LeagueInfoScreen(
                      leagueId: widget.leagueId,
                      subType: league.data!.subType!,
                    ),
                  );
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
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
                    widget.roundId != null
                        ? "${league.data!.name}-${context.appLocalization.week} ${phase.data!.name}"
                        : "${league.data!.name}-${phase.data!.name}",
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
          ),
        );
      },
    );
  }
}
