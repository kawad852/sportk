import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/home/widgets/live_bubble.dart';
import 'package:sportk/screens/home/widgets/team_widget.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/web_view_screen.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class HomeBubble extends StatefulWidget {
  final DateTime date;
  final String leagueId;
  final List<LiveData> lives;
  final bool isLive;

  const HomeBubble({
    super.key,
    required this.date,
    required this.leagueId,
    required this.lives,
    required this.isLive,
  });

  @override
  State<HomeBubble> createState() => _HomeBubbleState();
}

class _HomeBubbleState extends State<HomeBubble> with AutomaticKeepAliveClientMixin {
  late Future<LeagueByDateModel> _future;
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;

  Future<LeagueByDateModel> _fetchLeagueByDate() {
    final snapshot = ApiService<LeagueByDateModel>().build(
      sportsUrl:
          '${ApiUrl.compoByDate}/${widget.date.formatDate(context, pattern: 'yyyy-MM-dd')}${ApiUrl.auth}&filters=fixtureLeagues:${widget.leagueId}&include=state;participants;statistics.type',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueByDateModel.fromJson,
    );
    return snapshot;
  }

  Future<List<dynamic>> _initializeFutures() {
    final leagueFuture = _footBallProvider.fetchLeague(leagueId: int.parse(widget.leagueId));
    final teamsFuture = ApiService<LeagueByDateModel>().build(
      sportsUrl:
          '${ApiUrl.compoByDate}/${widget.date.formatDate(context, pattern: 'yyyy-MM-dd')}${ApiUrl.auth}&filters=fixtureLeagues:${widget.leagueId}&include=statistics;state;participants;periods.events',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueByDateModel.fromJson,
    );
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
    return CustomFutureBuilder(
      future: _futures,
      onRetry: () {
        setState(() {
          _futures = _initializeFutures();
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
      onComplete: (context, snapshot) {
        final league = snapshot.data![0] as LeagueModel;
        final matchModel = snapshot.data![1] as LeagueByDateModel;
        List<MatchData> matches = [];
        if (widget.isLive) {
          final liveMatches = widget.lives.map((e) => e.matchId).toList();
          matches =
              matchModel.data!.where((element) => liveMatches.contains('${element.id}')).toList();
        } else {
          matches = matchModel.data!;
        }
        if (matches.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            LeagueTile(
              league: league.data!,
              onTap: () {
                if (league.data!.subType == LeagueTypeEnum.cubInternational) {
                  context.push(
                    ChampionsLeagueScreen(leagueId: int.parse(widget.leagueId)),
                  );
                } else {
                  context.push(
                    LeagueInfoScreen(
                        leagueId: int.parse(widget.leagueId), subType: league.data!.subType!),
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
                final liveMatch = widget.lives.singleWhere(
                    (element) => element.matchId == '${match.id}',
                    orElse: () => LiveData());
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
                                element.state!.id != 1 &&
                                        element.state!.id != 13 &&
                                        element.state!.id != 10
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
                                element.state!.id != 1 &&
                                        element.state!.id != 13 &&
                                        element.state!.id != 10
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
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
