import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_network_image.dart';

import 'widgets/champions_groups.dart';
import 'widgets/champions_matches.dart';

class ChampionsLeagueScreen extends StatefulWidget {
  const ChampionsLeagueScreen({super.key});

  @override
  State<ChampionsLeagueScreen> createState() => _ChampionsLeagueScreenState();
}

class _ChampionsLeagueScreenState extends State<ChampionsLeagueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            leadingWidth: kBarLeadingWith,
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Champions League",
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flexibleSpace: Stack(
              children: [
                Image.asset(
                  MyImages.match,
                  height: 270,
                  width: double.infinity,
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
                        controller: _controller,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: context.colorPalette.white,
                        unselectedLabelColor: context.colorPalette.blueD4B,
                        labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
                        indicator: BoxDecoration(
                          color: context.colorPalette.blueD4B,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabs: [
                          Center(child: Text(context.appLocalization.groups)),
                          Center(child: Text(context.appLocalization.matches)),
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
                ChampionsGroups(),
                ChampionsMatches(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
