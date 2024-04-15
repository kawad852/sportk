import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/player_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_cell.dart';
import 'package:sportk/widgets/league_scorers/league_scorers_loading.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/team_name.dart';

class AssistersScorers extends StatefulWidget {
  final int leagueId;
  const AssistersScorers({super.key, required this.leagueId});

  @override
  State<AssistersScorers> createState() => _AssistersScorersState();
}

class _AssistersScorersState extends State<AssistersScorers> with AutomaticKeepAliveClientMixin {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<TopScorersModel> _topScorersFuture;

  Future<List<dynamic>> _initializeFutures() async {
    final seasonFuture = _footBallProvider.fetchSeasonByLeague(leagueId: widget.leagueId);
    final season = await seasonFuture;
    _topScorersFuture = _footBallProvider.fetchTopScorers(
      seasonId: season.data!.currentseason!.id!,
      topScorerType: 209,
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
    super.build(context);
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
        final topAsissters = snapshot.data![0] as TopScorersModel;
        return topAsissters.data!.isEmpty
            ? NoResults(
                header: const Icon(FontAwesomeIcons.trophy),
                title: context.appLocalization.noAsisstersAvailable,
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
                              child: LeagueScorersCell(text: context.appLocalization.assist),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: topAsissters.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final element = topAsissters.data![index];
                        return Padding(
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colorPalette.grey3F3,
                              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                            ),
                            child: InkWell(
                              onTap: () =>
                                  context.push(PlayerScreen(playerId: element.player!.id!)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      element.position.toString(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        CustomNetworkImage(
                                          element.player!.imagePath!,
                                          width: 35,
                                          height: 35,
                                          shape: BoxShape.circle,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                element.player!.displayName!,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: context.colorPalette.blueD4B,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              TeamName(
                                                teamId: element.participantId,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        element.total.toString(),
                                        style: TextStyle(
                                          color: context.colorPalette.blueD4B,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
