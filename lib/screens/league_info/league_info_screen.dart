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
import 'package:sportk/widgets/favorite_button.dart';
import 'package:sportk/widgets/league_loading.dart';
import 'package:sportk/widgets/league_scorers/league_scorers.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueInfoScreen extends StatefulWidget {
  final int leagueId;
  final String subType;
  final int initialIndex;

  const LeagueInfoScreen({
    super.key,
    required this.leagueId,
    required this.subType,
    this.initialIndex = 0,
  });

  @override
  State<LeagueInfoScreen> createState() => _LeagueInfoScreenState();
}

class _LeagueInfoScreenState extends State<LeagueInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;

  bool get _isDomestic => widget.subType == LeagueTypeEnum.domestic;

  void _initializeFuture() {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: widget.leagueId);
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _isDomestic ? 4 : 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
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
            actions: [
              FavoriteButton(
                id: widget.leagueId,
                type: CompoTypeEnum.competitions,
              ),
            ],
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MyTheme.isLightTheme(context)
                        ? MyImages.backgroundLeague
                        : MyImages.backgroundClubDark,
                  ),
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
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: context.colorPalette.league,
                              child: CustomNetworkImage(
                                league.data!.imagePath!,
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                width: 100,
                                height: 100,
                              ),
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
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        color: context.colorPalette.grey9E9,
                      ),
                      child: TabBar(
                        controller: _controller,
                        dividerColor: Colors.transparent,
                        indicatorColor: context.colorPalette.tabColor,
                        labelColor: context.colorPalette.tabColor,
                        labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                        tabs: [
                          if (_isDomestic) Text(context.appLocalization.standings),
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
                if (_isDomestic) LeagueStandings(leagueId: widget.leagueId),
                LeagueScorers(leagueId: widget.leagueId),
                _isDomestic
                    ? LeagueMatches(leagueId: widget.leagueId)
                    : ChampionsMatches(leagueId: widget.leagueId),
                NewTab(id: widget.leagueId, type: NewTypeEnum.league),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
