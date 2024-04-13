import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_cell.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_loading.dart';
import 'package:sportk/widgets/league_scorers/scorers_card.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueScorers extends StatefulWidget {
  final int leagueId;
  const LeagueScorers({super.key, required this.leagueId});

  @override
  State<LeagueScorers> createState() => _LeagueScorersState();
}

class _LeagueScorersState extends State<LeagueScorers> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<TopScorersModel> _topScorersFuture;

  Future<List<dynamic>> _initializeFutures() async {
    final seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: widget.leagueId);
    final season = await seasonFuture;
    _topScorersFuture = _footBallProvider.fetchTopScorers(
      seasonId: season.data!.currentseason!.id!,
      topScorerType: 208,
    );
    return Future.wait([_topScorersFuture]);
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
        return const ShimmerLoading(
          child: LeagueScorersLoading(),
        );
      },
      onComplete: (context, snapshot) {
        final topScorers = snapshot.data![0] as TopScorersModel;
        return topScorers.data!.isEmpty
            ? NoResults(
                header: const Icon(FontAwesomeIcons.trophy),
                title: context.appLocalization.noScorerAvailable,
              )
            : SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: context.colorPalette.grey3F3,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: LeagueScorersCell(text: context.appLocalization.st),
                            ),
                            Expanded(
                              flex: 5,
                              child: LeagueScorersCell(text: context.appLocalization.player),
                            ),
                            Expanded(
                              flex: 2,
                              child: LeagueScorersCell(text: context.appLocalization.goals),
                            ),
                            Expanded(
                              flex: 2,
                              child: LeagueScorersCell(text: context.appLocalization.goalsPenalty),
                            ),
                            Expanded(
                              flex: 2,
                              child: LeagueScorersCell(text: context.appLocalization.missedPenalty),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: topScorers.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final element = topScorers.data![index];
                        return ScorersCard(
                          topScoreData: element,
                        );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
