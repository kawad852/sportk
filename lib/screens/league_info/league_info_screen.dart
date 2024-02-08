import 'package:flutter/material.dart';
import 'package:sportk/screens/league_info/widgets/league_news.dart';
import 'package:sportk/screens/league_info/widgets/league_scorers.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/widgets/matches_card.dart';

class LeagueInfoScreen extends StatefulWidget {
  const LeagueInfoScreen({super.key});

  @override
  State<LeagueInfoScreen> createState() => _LeagueInfoScreenState();
}

class _LeagueInfoScreenState extends State<LeagueInfoScreen> with SingleTickerProviderStateMixin {
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
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            leadingWidth: 500,
            pinned: true,
            leading: CustomBack(
              color: context.colorPalette.white,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 65),
                child: Column(
                  children: [
                    const CustomNetworkImage(
                      kFakeImage,
                      width: 100,
                      height: 100,
                      radius: 0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Premier League",
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
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
                    height: 270,
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
                          Text(context.appLocalization.standings),
                          Text(context.appLocalization.scorers),
                          Text(context.appLocalization.table),
                          Text(context.appLocalization.news),
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
                LeagueStandings(),
                LeagueScorers(),
                MatchesCard(),
                LeagueNews(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
