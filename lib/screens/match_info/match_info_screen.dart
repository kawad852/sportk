import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
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
  const MatchInfoScreen({super.key});

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                  const MatchCard(),
                  const SizedBox(
                    height: 10,
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
                        isScrollable: true,
                        indicatorColor: context.colorPalette.blueD4B,
                        labelColor: context.colorPalette.blueD4B,
                        tabAlignment: TabAlignment.center,
                        indicatorSize: TabBarIndicatorSize.label,
                        //padding: const EdgeInsets.only(top: 8),
                        labelPadding: const EdgeInsetsDirectional.only(bottom: 8, end: 30, top: 10),
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        tabs: [
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
                          Text(context.appLocalization.standings),
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
                Text(context.appLocalization.predictAndWin),
                MatchEvents(),
                TeamsPlan(),
                MatchStatistics(),
                LeagueStandings(leagueId: 564),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
