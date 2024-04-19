import 'package:flutter/material.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class FinalResult extends StatefulWidget {
  final int matchId;
  final int homeGoalsGoing;
  final int awayGoalsGoing;

  const FinalResult(
      {super.key,
      required this.matchId,
      required this.homeGoalsGoing,
      required this.awayGoalsGoing});

  @override
  State<FinalResult> createState() => _FinalResultState();
}

class _FinalResultState extends State<FinalResult> {
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
        return const ShimmerLoading(
          child: LoadingBubble(
            width: 64,
            height: 25,
            radius: MyTheme.radiusSecondary,
          ),
        );
      },
      onComplete: (context, snapshot) {
        final match = snapshot.data!;
        int homeGoals = 0;
        int awayGoals = 0;
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
        return Container(
          width: 64,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorPalette.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
          ),
          child:
              Text("${awayGoals + widget.homeGoalsGoing}  -  ${homeGoals + widget.awayGoalsGoing}"),
        );
      },
    );
  }
}
