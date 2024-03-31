import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/favorite_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/screens/profile/profile_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/builders/league_builder.dart';
import 'package:sportk/widgets/builders/team_builder.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/favorite_button.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/menu_button.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/team_bubble.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with AutomaticKeepAliveClientMixin {
  late FavoriteProvider _favoriteProvider;
  late Future<FavoriteModel?> _favoritesFuture;

  void _initializeFuture() {
    _favoritesFuture = _favoriteProvider.fetchFavs(context);
  }

  @override
  void initState() {
    super.initState();
    _favoriteProvider = context.favoriteProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: const ProfileScreen(),
      appBar: AppBar(
        leading: const MenuButton(),
        title: Text(context.appLocalization.favorites),
      ),
      body: CustomFutureBuilder(
        future: _favoritesFuture,
        onRetry: () {},
        onLoading: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
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
              ),
              Expanded(
                child: ShimmerLoading(
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
                ),
              )
            ],
          );
        },
        onComplete: (context, snapshot) {
          return Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
              provider.favorites = snapshot.data!.data!;
              final teamsFavorites = provider.favorites.where((element) => element.type == CompoTypeEnum.teams).toList();
              final leagueFavorites = provider.favorites.where((element) => element.type == CompoTypeEnum.competitions).toList();
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
                    child: SizedBox(
                      height: 165,
                      child: ListView.separated(
                        itemCount: teamsFavorites.length,
                        padding: const EdgeInsets.all(20),
                        separatorBuilder: (context, index) => const SizedBox(width: 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final favoriteData = teamsFavorites[index];
                          final id = favoriteData.favoritableId!;
                          return TeamBuilder(
                            key: ValueKey(index),
                            teamId: id,
                            builder: (context, teamData) {
                              return TeamBubble(
                                team: teamData,
                                selected: _favoriteProvider.isFav(id, CompoTypeEnum.teams),
                                showDialog: true,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: leagueFavorites.length,
                      padding: const EdgeInsets.all(20),
                      separatorBuilder: (context, index) => const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        final favoriteData = leagueFavorites[index];
                        final id = favoriteData.favoritableId!;
                        return LeagueBuilder(
                          key: ValueKey(index),
                          leagueId: id,
                          builder: (BuildContext context, LeagueModel leagueModel) {
                            final league = leagueModel.data!;
                            return LeagueTile(
                              league: league,
                              onTap: () {
                                UiHelper.navigateToLeagueInfo(
                                  context,
                                  leagueData: leagueModel.data!,
                                );
                              },
                              trailing: FavoriteButton(
                                id: id,
                                type: CompoTypeEnum.competitions,
                                name: league.name!,
                                showDialog: true,
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
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
