import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/model/matches/our_league_model.dart';
import 'package:sportk/model/matches/our_teams_model.dart';
import 'package:sportk/model/teams_by_season_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/screens/registration/registration_screen.dart';
import 'package:sportk/screens/search/search_screen.dart';
import 'package:sportk/screens/wizard/leagues_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/search_field.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/stretch_button.dart';
import 'package:sportk/widgets/team_bubble.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late AuthProvider _authProvider;
  late FavoriteProvider _favoriteProvider;

  Future<OurTeamsModel> _fetchTeams(int pageKey) {
    final snapshot = ApiService<OurTeamsModel>().build(
      weCanUrl: '${ApiUrl.ourTeams}?page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: OurTeamsModel.fromJson,
    );
    return snapshot;
  }

  Future<OurLeaguesModel> _fetchLeagues(int pageKey) {
    final snapshot = ApiService<OurLeaguesModel>().build(
      weCanUrl: '${ApiUrl.ourLeagues}?page=$pageKey',
      isPublic: true,
      apiType: ApiType.get,
      builder: OurLeaguesModel.fromJson,
    );
    return snapshot;
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _favoriteProvider = context.favoriteProvider;
    _favoriteProvider.fetchFavs(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _favoriteProvider.favFuture!,
      onRetry: () {
        setState(() {
          _favoriteProvider.fetchFavs(context);
        });
      },
      onComplete: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.appLocalization.followYourTeam),
            actions: [
              TextButton(
                onPressed: () {
                  context.pushAndRemoveUntil(const AppNavBar());
                },
                child: Text(context.appLocalization.skip),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Center(
              child: _authProvider.isAuthenticated
                  ? StretchedButton(
                      onPressed: () {},
                      child: Text(context.appLocalization.save),
                    )
                  : StretchedButton(
                      onPressed: () {
                        context.push(const RegistrationScreen());
                      },
                      child: Text(context.appLocalization.next),
                    ),
            ),
          ),
          body: Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Material(
                    child: Column(
                      children: [
                        VexPaginator(
                          query: (pageKey) async => _fetchTeams(pageKey),
                          onFetching: (snapshot) async => snapshot.data!,
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
                                itemCount: snapshot.docs.length,
                                padding: const EdgeInsets.all(20),
                                separatorBuilder: (context, index) => const SizedBox(width: 5),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                                    snapshot.fetchMore();
                                    return const VexLoader();
                                  }

                                  final team = snapshot.docs[index] as TeamBySeasonData;
                                  final id = team.id!;
                                  return TeamBubble(
                                    team: team,
                                    onTap: () {
                                      _favoriteProvider.toggleFavorites(id, CompoTypeEnum.teams);
                                    },
                                    selected: _favoriteProvider.isFav(id, CompoTypeEnum.teams),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SearchTextField(
                            onChanged: (value) {},
                            readOnly: true,
                            onTap: () {
                              context.push(const SearchScreen());
                            },
                            hintText: context.appLocalization.clubSearchHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: VexPaginator(
                      query: (pageKey) async => _fetchLeagues(pageKey),
                      onFetching: (snapshot) async => snapshot.data!,
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
                          itemCount: snapshot.docs.length,
                          padding: const EdgeInsets.all(20),
                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                          itemBuilder: (context, index) {
                            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                              snapshot.fetchMore();
                              return const VexLoader();
                            }
                            final league = snapshot.docs[index] as LeagueData;
                            final id = league.id!;
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
                                onPressed: () {
                                  _favoriteProvider.toggleFavorites(id, CompoTypeEnum.competitions);
                                },
                                icon: CustomSvg(
                                  _favoriteProvider.isFav(id, CompoTypeEnum.competitions) ? MyIcons.starFilled : MyIcons.starOutlined,
                                ),
                              ),
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
      },
    );
  }
}
