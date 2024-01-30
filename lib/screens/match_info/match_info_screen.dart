import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/screens/match_info/widgets/league_standings.dart';
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
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 500,
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
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: Padding(
                padding: EdgeInsetsDirectional.only(bottom: 65),
                child: MatchCard(),
              ),
            ),
            flexibleSpace: Stack(
              children: [
                Image.asset(
                  MyImages.match,
                  height: 270,
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: context.colorPalette.white.withOpacity(0.6),
                          offset: const Offset(0, 0),
                          blurRadius: 30,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.colorPalette.grey9E9,
                      ),
                      child: TabBar(
                        controller: controller,
                        indicatorColor: context.colorPalette.blueD4B,
                        labelColor: context.colorPalette.blueD4B,
                        labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                        tabs: [
                          Text(context.appLocalization.matchEvents),
                          Text(context.appLocalization.plan),
                          Text(context.appLocalization.statistics),
                          Text(context.appLocalization.standings),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: controller,
              children: const [
                MatchEvents(),
                TeamsPlan(),
                MatchStatistics(),
                LeagueStandings(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
