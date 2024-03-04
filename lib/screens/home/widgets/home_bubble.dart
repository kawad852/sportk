import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/home/widgets/live_bubble.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/web_view_screen.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class HomeBubble extends StatefulWidget {
  final DateTime date;
  final int id;
  final String type;
  final List<LiveData> lives;
  final bool isLive;
  final int index;
  final int length;

  const HomeBubble({
    super.key,
    required this.date,
    required this.id,
    required this.lives,
    required this.isLive,
    required this.type,
    required this.index,
    required this.length,
  });

  @override
  State<HomeBubble> createState() => HomeBubbleState();
}

class HomeBubbleState extends State<HomeBubble> with AutomaticKeepAliveClientMixin {
  late Future<LeagueByDateModel> _future;
  late FootBallProvider _footBallProvider;
  late Future<LeagueByDateModel> _teamsFuture;
  late Future<List<dynamic>> _futures;

  int get _id => widget.id;
  String get _type => widget.type;
  int get _index => widget.index;

  Future<List<dynamic>> _initializeFutures() async {
    late int leagueId;
    late Future<LeagueModel> leagueFuture;
    late Future<LeagueByDateModel> teamsFuture;
    if (_type == CompoTypeEnum.teams) {
      final leagueByTeamFuture = _footBallProvider.fetchLeagueByTeam(context, widget.date, _id);
      final team = await leagueByTeamFuture;
      final id = team.data!.first.leagueId!;
      leagueId = id;
    } else {
      leagueId = _id;
    }
    if (!context.mounted) return [];
    leagueFuture = _footBallProvider.fetchLeague(leagueId: leagueId);
    teamsFuture = _footBallProvider.fetchLeagueByDate(context, widget.date, leagueId);
    return Future.wait([leagueFuture, teamsFuture]);
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
    // if (_type == CompoTypeEnum.teams) {
    //   return GestureDetector(
    //     onTap: () {
    //       print("id::: $_id");
    //     },
    //     child: const CircleAvatar(),
    //   );
    // }

    return CustomFutureBuilder(
      future: _futures,
      onRetry: () {
        setState(() {
          _initializeFutures();
        });
      },
      onLoading: () {
        return ShimmerLoading(
          child: ListView.separated(
            itemCount: 3,
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
      onError: (snapshot) {
        return const SizedBox.shrink();
      },
      onComplete: (context, snapshot) {
        if (snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }
        final leagueModel = snapshot.data![0] as LeagueModel;
        final matchModel = snapshot.data![1] as LeagueByDateModel;
        List<MatchData> matches = [];
        if (widget.isLive) {
          final liveMatches = widget.lives.map((e) => e.matchId).toList();
          matches = matchModel.data!.where((element) => liveMatches.contains('${element.id}')).toList();
        } else {
          matches = matchModel.data!;
        }
        if (matches.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            LeagueTile(
              league: leagueModel.data!,
              onTap: () {
                if (leagueModel.data!.subType == LeagueTypeEnum.cubInternational) {
                  context.push(
                    ChampionsLeagueScreen(leagueId: _id),
                  );
                } else {
                  context.push(
                    LeagueInfoScreen(leagueId: _id, subType: leagueModel.data!.subType!),
                  );
                }
              },
            ),
            ListView.separated(
              itemCount: matches.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 5),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final match = matches[index];
                final liveMatch = widget.lives.singleWhere((element) => element.matchId == '${match.id}', orElse: () => LiveData());
                final element = matches[index];
                int homeGoals = 0;
                int awayGoals = 0;
                int? minute;
                element.periods!.map((period) {
                  if (period.hasTimer!) {
                    minute = period.minutes;
                  }
                }).toSet();
                element.statistics!.map(
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
                return GestureDetector(
                  onTap: () {
                    context.push(WebViewScreen(matchId: match.id!));
                  },
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: context.colorPalette.blue1FC,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            element.participants![0].name!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        CustomNetworkImage(
                          element.participants![0].imagePath!,
                          width: 30,
                          height: 30,
                          shape: BoxShape.circle,
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 10, end: 5),
                            child: Row(
                              children: [
                                element.state!.id != 1 && element.state!.id != 13 && element.state!.id != 10
                                    ? Padding(
                                        padding: const EdgeInsetsDirectional.only(end: 5),
                                        child: Text("$homeGoals"),
                                      )
                                    : const SizedBox(
                                        width: 6,
                                      ),
                                minute != null
                                    ? CircleAvatar(
                                        child: Text("$minute"),
                                      )
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            element.state!.name!,
                                            style: TextStyle(
                                              color: context.colorPalette.green057,
                                              fontSize: 8,
                                            ),
                                          ),
                                          if (element.state!.id == 1)
                                            Text(
                                              DateFormat("yyyy-MM-dd").format(element.startingAt!),
                                              style: const TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          if (element.state!.id == 1)
                                            Text(
                                              DateFormat("HH:mm").format(element.startingAt!),
                                              style: const TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                        ],
                                      ),
                                element.state!.id != 1 && element.state!.id != 13 && element.state!.id != 10
                                    ? Padding(
                                        padding: const EdgeInsetsDirectional.only(start: 3),
                                        child: Text("$awayGoals"),
                                      )
                                    : const SizedBox(
                                        width: 8,
                                      )
                              ],
                            ),
                          ),
                        ),
                        CustomNetworkImage(
                          element.participants![1].imagePath!,
                          width: 30,
                          height: 30,
                          shape: BoxShape.circle,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            element.participants![1].name!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        if (liveMatch.id != null) LiveBubble(liveData: liveMatch),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_index != 0 && _index % 4 == 0 && _index + 1 != widget.length)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: GoogleBanner(),
              ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
