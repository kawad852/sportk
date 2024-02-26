import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class ClubStandings extends StatefulWidget {
  final int teamId;
  const ClubStandings({super.key, required this.teamId});

  @override
  State<ClubStandings> createState() => _ClubStandingsState();
}

class _ClubStandingsState extends State<ClubStandings> {
  List<LeagueModel> leagues = <LeagueModel>[];
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<TeamInfoModel> _teamFuture;
  late Future<LeagueModel> _leagueFuture;

  Future<List<dynamic>> _initializeFutures() async {
    _teamFuture = _footBallProvider.fetchTeamSeasons(teamId: widget.teamId);
    final team = await _teamFuture;
    return Future.wait(team.data!.seasons!.map((element) async {
      if (element.isCurrent == true) {
        _leagueFuture = _footBallProvider.fetchLeague(leagueId: element.leagueId!);
        final leagueInfo = await _leagueFuture;
        leagues.add(leagueInfo);
      }
    }).toSet());
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
        return ShimmerLoading(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8, start: 10, bottom: 8),
                child: SizedBox(
                  height: 35.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return const LoadingBubble(
                        height: 30,
                        width: 100,
                        margin: EdgeInsetsDirectional.only(start: 5, end: 5),
                        radius: MyTheme.radiusPrimary,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onComplete: (context, snapshot) {
        int localLeagueId = 0;
        leagues.map(
          (e) async {
            if (e.data!.subType == LeagueTypeEnum.domestic) {
              localLeagueId = e.data!.id!;
            }
          },
        ).toSet();
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8, start: 10, bottom: 8),
                child: SizedBox(
                  height: 35.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: leagues.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          leagues[index].data!.id == 2 || leagues[index].data!.id == 5
                              ? context.push(
                                  ChampionsLeagueScreen(
                                    leagueId: leagues[index].data!.id!,
                                    teamId: widget.teamId,
                                  ),
                                )
                              : context.push(
                                  LeagueInfoScreen(
                                    leagueId: leagues[index].data!.id!,
                                    subType: leagues[index].data!.subType! ,
                                  ),
                                );
                        },
                        child: Container(
                          height: 30,
                          margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
                          decoration: BoxDecoration(
                            color: context.colorPalette.greyEAE,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                  leagues[index].data!.imagePath!,
                                  width: 20,
                                  height: 20,
                                  radius: 0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  leagues[index].data!.name!,
                                  style: TextStyle(
                                    color: context.colorPalette.blueD4B,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              LeagueStandings(
                leagueId: localLeagueId,
                selectedTeamId: widget.teamId,
              ),
            ],
          ),
        );
      },
    );
  }
}
