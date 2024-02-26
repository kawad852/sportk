import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/widgets/champions_matches.dart';
import 'package:sportk/screens/league_info/widgets/league_matches.dart';
import 'package:sportk/screens/league_info/widgets/league_news.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_loading.dart';
import 'package:sportk/widgets/league_scorers/league_scorers.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueInfoScreen extends StatefulWidget {
  final int leagueId;
  final String subType;
  const LeagueInfoScreen({super.key, required this.leagueId, required this.subType});

  @override
  State<LeagueInfoScreen> createState() => _LeagueInfoScreenState();
}

class _LeagueInfoScreenState extends State<LeagueInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;

  void _initializeFuture() {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: widget.leagueId);
  }

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widget.subType == LeagueTypeEnum.domestic ? 4 : 3, vsync: this);
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            leadingWidth: kBarLeadingWith,
            collapsedHeight: kBarCollapsedHeight,
            pinned: true,
            leading: CustomBack(
              color: context.colorPalette.white,
            ),
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MyImages.backgroundLeague),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomFutureBuilder(
                    future: _leagueFuture,
                    onRetry: () {
                      setState(() {
                        _initializeFuture();
                      });
                    },
                    onLoading: () {
                      return const ShimmerLoading(child: LeagueLoading());
                    },
                    onError: (snapshot) => const SizedBox.shrink(),
                    onComplete: (context, snapshot) {
                      final league = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 30),
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              league.data!.imagePath!,
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              league.data!.name!,
                              style: TextStyle(
                                color: context.colorPalette.blueD4B,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.colorPalette.grey9E9,
                      ),
                      child: TabBar(
                        controller: _controller,
                        indicatorColor: context.colorPalette.blueD4B,
                        labelColor: context.colorPalette.blueD4B,
                        labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                        tabs: [
                          if (widget.subType == LeagueTypeEnum.domestic)
                            Text(context.appLocalization.standings),
                          Text(context.appLocalization.scorers),
                          Text(context.appLocalization.table),
                          Text(context.appLocalization.news),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _controller,
              children: [
                if (widget.subType == LeagueTypeEnum.domestic)
                  LeagueStandings(leagueId: widget.leagueId),
                LeagueScorers(leagueId: widget.leagueId),
                widget.subType == LeagueTypeEnum.domestic
                    ? LeagueMatches(leagueId: widget.leagueId)
                    : ChampionsMatches(leagueId: widget.leagueId),
                const LeagueNews(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
