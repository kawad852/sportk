import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_loading.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'widgets/champions_groups.dart';
import 'widgets/champions_matches.dart';

class ChampionsLeagueScreen extends StatefulWidget {
  final int? teamId;
  const ChampionsLeagueScreen({super.key, this.teamId});

  @override
  State<ChampionsLeagueScreen> createState() => _ChampionsLeagueScreenState();
}

class _ChampionsLeagueScreenState extends State<ChampionsLeagueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;

  void _initializeFuture() {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: 2);
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
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
            pinned: true,
            leading: CustomBack(
              color: context.colorPalette.white,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: CustomFutureBuilder(
                future: _leagueFuture,
                onRetry: () {
                  setState(() {
                    _initializeFuture();
                  });
                },
                onLoading: () => const ShimmerLoading(child: LeagueLoading()),
                onError: (snapshot) => const SizedBox.shrink(),
                onComplete: (context, snapshot) {
                  final league = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 65),
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
              children:  [
                ChampionsGroups(teamId: widget.teamId),
                const ChampionsMatches(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
