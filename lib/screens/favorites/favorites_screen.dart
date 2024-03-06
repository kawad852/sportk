import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/favorite_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/screens/wizard/leagues_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/builders/league_builder.dart';
import 'package:sportk/widgets/builders/team_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/team_bubble.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with AutomaticKeepAliveClientMixin {
  late FavoriteProvider _favoriteProvider;
  late Future<FavoriteModel?> _future;

  // void _fetch() {
  //   _future = _favoriteProvider.fetchFavs(context);
  // }

  @override
  void initState() {
    super.initState();
    _favoriteProvider = context.favoriteProvider;
    // _fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.favorites),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return Center(
              child: NoResults(
                header: const CustomSvg(
                  MyIcons.starFilled,
                  width: 60,
                ),
                title: context.appLocalization.favEmptyTitle,
                body: context.appLocalization.favEmptyBody,
              ),
            );
          }
          return Column(
            children: [
              Material(
                child: Column(
                  children: [
                    VexPaginator(
                      query: (pageKey) async => _favoriteProvider.fetchFavs(context, pageKey),
                      onFetching: (snapshot) async => snapshot.data!.where((element) => element.type == CompoTypeEnum.teams).toList(),
                      pageSize: 10,
                      onLoading: () {
                        return ShimmerLoading(
                          child: SizedBox(
                            height: 165,
                            child: ListView.separated(
                              itemCount: 15,
                              padding: const EdgeInsets.all(20),
                              separatorBuilder: (context, index) => const SizedBox(width: 5),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return const LoadingBubble(
                                  width: 100,
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
                            padding: const EdgeInsets.all(20),
                            separatorBuilder: (context, index) => const SizedBox(width: 5),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                snapshot.fetchMore();
                              }

                              if (index == snapshot.docs.length) {
                                return VexLoader(snapshot.isFetchingMore);
                              }

                              final favoriteData = snapshot.docs[index] as FavoriteData;
                              final id = favoriteData.favoritableId!;
                              return TeamBuilder(
                                  key: ValueKey(index),
                                  teamId: id,
                                  builder: (context, teamData) {
                                    return TeamBubble(
                                      team: teamData,
                                      onTap: () async {
                                        final result = await _favoriteProvider.toggleFavorites(id, CompoTypeEnum.teams, teamData.name!);
                                        if (result) {
                                          setState(() {
                                            snapshot.docs.removeAt(index);
                                          });
                                        }
                                      },
                                      selected: _favoriteProvider.isFav(id, CompoTypeEnum.teams),
                                    );
                                  });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: VexPaginator(
                  query: (pageKey) async => _favoriteProvider.fetchFavs(context, pageKey),
                  onFetching: (snapshot) async => snapshot.data!.where((element) => element.type == CompoTypeEnum.competitions).toList(),
                  pageSize: 10,
                  onLoading: () {
                    return ShimmerLoading(
                      child: ListView.separated(
                        itemCount: 15,
                        padding: const EdgeInsets.all(20),
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          return const LoadingBubble(
                            height: 40,
                            radius: MyTheme.radiusPrimary,
                          );
                        },
                      ),
                    );
                  },
                  builder: (context, snapshot) {
                    return ListView.separated(
                      itemCount: snapshot.docs.length + 1,
                      padding: const EdgeInsets.all(20),
                      separatorBuilder: (context, index) => const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }

                        if (index == snapshot.docs.length) {
                          return VexLoader(snapshot.isFetchingMore);
                        }

                        final favoriteData = snapshot.docs[index] as FavoriteData;
                        final id = favoriteData.favoritableId!;
                        return LeagueBuilder(
                          key: ValueKey(index),
                          leagueId: id,
                          builder: (BuildContext context, LeagueModel leagueModel) {
                            final league = leagueModel.data!;
                            return LeagueTile(
                              league: league,
                              onTap: () {
                                context
                                    .push(
                                  LeaguesScreen(
                                    leagueId: league.id!,
                                    leagueName: league.name!,
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              trailing: IconButton(
                                onPressed: () async {
                                  final result = await _favoriteProvider.toggleFavorites(id, CompoTypeEnum.competitions, league.name!);
                                  if (result) {
                                    setState(() {
                                      snapshot.docs.removeAt(index);
                                    });
                                  }
                                },
                                icon: CustomSvg(
                                  _favoriteProvider.isFav(id, CompoTypeEnum.competitions) ? MyIcons.starFilled : MyIcons.starOutlined,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
