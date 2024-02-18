import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/matches_card.dart';
import 'package:sportk/screens/club/widgets/club_news.dart';
import 'package:sportk/screens/club/widgets/club_players.dart';
import 'package:sportk/screens/club/widgets/club_standings.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: kBarLeadingWith,
            pinned: true,
            leading: CustomBack(
              color: context.colorPalette.white,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const CustomSvg(MyIcons.starWhite),
              ),
            ],
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
                      "Bayern Munich",
                      style: TextStyle(
                        color: context.colorPalette.white,
                        fontWeight: FontWeight.w600,
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
                        controller: _controller,
                        indicatorColor: context.colorPalette.blueD4B,
                        labelColor: context.colorPalette.blueD4B,
                        labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                        tabs: [
                          Text(context.appLocalization.matches),
                          Text(context.appLocalization.news),
                          Text(context.appLocalization.standings),
                          Text(context.appLocalization.players),
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
              controller: _controller,
              children: const [
                MatchesCard(),
                ClubNews(),
                ClubStandings(),
                ClubPlayers(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
