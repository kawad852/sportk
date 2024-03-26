import 'package:flutter/material.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/match_info/predictions/widgets/viewers_predictions.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class MatchEvents extends StatefulWidget {
  final int matchId;
  const MatchEvents({super.key, required this.matchId});

  @override
  State<MatchEvents> createState() => _MatchEventsState();
}

class _MatchEventsState extends State<MatchEvents> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late CommonProvider _commonProvider;
  late Future<MatchPointsModel> _matchPointsFuture;
  late Future<SingleMatchModel> _matchFuture;

  Future<List<dynamic>> _initializeFutures() async {
    _matchPointsFuture = _commonProvider.getMatchPoints(widget.matchId);
    _matchFuture = _footBallProvider.fetchMatchById(matchId: widget.matchId);
    return Future.wait([_matchPointsFuture, _matchFuture]);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _commonProvider = context.commonProvider;
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
      onComplete: (context, snapshot) {
        final matchPoint = snapshot.data![0] as MatchPointsModel;
        final match = snapshot.data![1] as SingleMatchModel;
        bool showPrediction = matchPoint.data!.totalPredictions!.home == 0 &&
            matchPoint.data!.totalPredictions!.away == 0 &&
            matchPoint.data!.totalPredictions!.draw == 0;
        return SingleChildScrollView(
          child: Column(
            children: [
              if (!showPrediction)
                ViewersPredictions(
                  pointsData: matchPoint.data!,
                  totalPredictions: matchPoint.data!.totalPredictions!,
                ),
              // ListView.separated(

              // ),
            ],
          ),
        );
      },
    );
  }
}
