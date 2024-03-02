import 'package:flutter/material.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/home/widgets/live_bubble.dart';
import 'package:sportk/screens/home/widgets/team_widget.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/web_view_screen.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
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
      sportsUrl: '${ApiUrl.compoByDate}/${widget.date.formatDate(context, pattern: 'yyyy-MM-dd')}${ApiUrl.auth}&filters=fixtureLeagues:${widget.leagueId}&include=state;participants;statistics.type',
      isPublic: true,
      apiType: ApiType.get,
      builder: LeagueByDateModel.fromJson,
    );
    return snapshot;
  }

  Future<List<dynamic>> _initializeFutures() {
    final leagueFuture = _footBallProvider.fetchLeague(leagueId: int.parse(widget.leagueId));
    final teamsFuture = ApiService<LeagueByDateModel>().build(
      sportsUrl: '${ApiUrl.compoByDate}/${widget.date.formatDate(context, pattern: 'yyyy-MM-dd')}${ApiUrl.auth}&filters=fixtureLeagues:${widget.leagueId}&include=state;participants;statistics.type',
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
          matches = matchModel.data!.where((element) => liveMatches.contains('${element.id}')).toList();
        } else {
          matches = matchModel.data!;
        }
        return Column(
          children: [
            LeagueTile(
              league: league.data!,
              onTap: () {
                context.push(LeagueInfoScreen(
                  leagueId: int.parse(widget.leagueId),
                  subType: "domestic",
                ));
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TeamWidget(
                                participant: match.participants![0],
                                reverse: false,
                              ),
                              const Text("2"),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: CircleAvatar(),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("2"),
                              TeamWidget(
                                participant: match.participants![1],
                                reverse: true,
                              ),
                            ],
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
