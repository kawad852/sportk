import 'package:flutter/material.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/screens/champions_league/widgets/champions_matches.dart';
import 'package:sportk/screens/match_info/predictions/predictions_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/screens/match_info/widgets/match_card.dart';
import 'package:sportk/screens/match_info/widgets/match_events.dart';
import 'package:sportk/screens/match_info/widgets/match_statistics.dart';
import 'package:sportk/screens/match_info/widgets/teams_plan.dart';

class MatchInfoScreen extends StatefulWidget {
  final int matchId;
  final int leagueId;
  final String subType;
  final PointsData pointsData;
  final bool showPredict;
  const MatchInfoScreen({
    super.key,
    required this.matchId,
    required this.pointsData,
    this.showPredict = false,
    required this.leagueId,
    required this.subType,
  });

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  bool get _showPredict => widget.showPredict;

  bool get _isDomestic => widget.subType == LeagueTypeEnum.domestic;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _showPredict ? 8 : 7, vsync: this);
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
              IconButton(
                onPressed: () {},
                icon: const CustomSvg(MyIcons.notification),
              ),
            ],
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MyTheme.isLightTheme(context)
                        ? MyImages.backgroundClub
                        : MyImages.backgroundClubDark,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MatchCard(
                    matchId: widget.matchId,
                    statusMatch: widget.pointsData.statusSoon!,
                  ),
                  const SizedBox(
                    height: 10,
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
                        isScrollable: true,
                        indicatorColor: context.colorPalette.tabColor,
                        labelColor: context.colorPalette.tabColor,
                        tabAlignment: TabAlignment.center,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: const EdgeInsetsDirectional.only(bottom: 8, end: 30, top: 10),
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        tabs: [
                          if (_showPredict)
                            Row(
                              children: [
                                const CustomSvg(
                                  MyIcons.coin,
                                  fixedColor: true,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(context.appLocalization.predictAndWin),
                              ],
                            ),
                          Text(context.appLocalization.matchEvents),
                          Text(context.appLocalization.plan),
                          Text(context.appLocalization.statistics),
                          Text(context.appLocalization.details),
                          Text(
                            _isDomestic
                                ? context.appLocalization.standings
                                : context.appLocalization.table,
                          ),
                          Text(context.appLocalization.scorers),
                          Text(context.appLocalization.headTwohead),
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
                if (_showPredict) PredictionsScreen(pointsData: widget.pointsData),
                MatchEvents(matchId: widget.matchId),
                TeamsPlan(),
                MatchStatistics(matchId: widget.matchId),
                Text(context.appLocalization.details),
                _isDomestic
                    ? LeagueStandings(
                        leagueId: widget.leagueId,
                        selectedTeamId: int.parse(widget.pointsData.homeId!),
                        selectedTeamId2: int.parse(widget.pointsData.awayId!),
                      )
                    : ChampionsMatches(leagueId: widget.leagueId),
                Text(context.appLocalization.scorers),
                Text(context.appLocalization.headTwohead),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
