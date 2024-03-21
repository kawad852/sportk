import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/favorite_button.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class LeaguesScreen extends StatefulWidget {
  const LeaguesScreen({super.key});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  late CommonProvider _commonProvider;
  late FootBallProvider _footBallProvider;

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _footBallProvider = context.footBallProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              context.appLocalization.trendingLeagues,
              style: context.textTheme.titleMedium,
            ),
          ),
          VexPaginator(
            query: (pageKey) async => _commonProvider.fetchOurLeagues(pageKey),
            onFetching: (snapshot) async => snapshot.data!,
            pageSize: 10,
            onLoading: () {
              return ShimmerLoading(
                child: SizedBox(
                  height: 140,
                  child: ListView.separated(
                    itemCount: 15,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    separatorBuilder: (context, index) => const SizedBox(width: 5),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Column(
                        children: [
                          LoadingBubble(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          LoadingBubble(
                            width: 80,
                            height: 20,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
            builder: (context, snapshot) {
              return SizedBox(
                height: 165,
                child: ListView.separated(
                  itemCount: snapshot.docs.length + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (context, index) => const SizedBox(width: 5),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }

                    if (index == snapshot.docs.length) {
                      return VexLoader(snapshot.isFetchingMore);
                    }
                    
                    final league = snapshot.docs[index] as LeagueData;
                    return GestureDetector(
                      onTap: () {
                        UiHelper.navigateToLeagueInfo(
                          context,
                          leagueData: league,
                        );
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              league.logo!,
                              height: 100,
                              width: 100,
                              boxFit: BoxFit.scaleDown,
                              scale: 2,
                              backgroundColor: context.colorPalette.grey3F1,
                              alignment: AlignmentDirectional.topStart,
                              child: FavoriteButton(
                                id: league.id!,
                                type: CompoTypeEnum.competitions,
                                showDialog: false,
                              ),
                            ),
                            Text(
                              league.name!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          VexPaginator(
            query: (pageKey) async => _footBallProvider.fetchLeaguesByCountry(id: '97374'),
            onFetching: (snapshot) async => snapshot.data!,
            pageSize: 10,
            onLoading: () {
              return ShimmerLoading(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const LoadingBubble(
                      height: 50,
                    );
                  },
                ),
              );
            },
            builder: (context, snapshot) {
              if (snapshot.docs.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      context.appLocalization.localLeagues,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  ListView.separated(
                    itemCount: snapshot.docs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final league = snapshot.docs[index] as LeagueData;
                      return LeagueTile(
                        league: league,
                        onTap: () {
                          UiHelper.navigateToLeagueInfo(
                            context,
                            leagueData: league,
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
