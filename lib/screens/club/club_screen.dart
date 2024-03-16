import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/widgets/club_loading.dart';
import 'package:sportk/screens/club/widgets/club_matches.dart';
import 'package:sportk/screens/club/widgets/club_players.dart';
import 'package:sportk/screens/club/widgets/club_standings.dart';
import 'package:sportk/screens/league_info/widgets/league_news.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/favorite_button.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class ClubScreen extends StatefulWidget {
  final int teamId;
  const ClubScreen({super.key, required this.teamId});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late FootBallProvider _footBallProvider;
  late Future<TeamInfoModel> _teamFuture;

  void _initializeFuture() {
    _teamFuture = _footBallProvider.fetchTeamInfo(teamId: widget.teamId);
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
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
                id: widget.teamId,
                type: CompoTypeEnum.teams,
              ),
            ],
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MyTheme.isLightTheme(context) ? MyImages.backgroundClub : MyImages.backgroundClubDark,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomFutureBuilder(
                    future: _teamFuture,
                    onRetry: () {
                      setState(() {
                        _initializeFuture();
                      });
                    },
                    onError: (snapshot) => const SizedBox.shrink(),
                    onLoading: () => const ShimmerLoading(child: ClubLoading()),
                    onComplete: (context, snapshot) {
                      final team = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 30),
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              team.data!.imagePath!,
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              team.data!.name!,
                              style: TextStyle(
                                color: context.colorPalette.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )
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
                        indicatorColor: context.colorPalette.tabColor,
                        labelColor: context.colorPalette.tabColor,
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
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _controller,
              children: [
                ClubMatches(teamId: widget.teamId),
                NewTab(id: widget.teamId, type: NewTypeEnum.league),
                ClubStandings(teamId: widget.teamId),
                ClubPlayers(teamId: widget.teamId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
