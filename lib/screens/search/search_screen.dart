import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/league_search_model.dart';
import 'package:sportk/model/player_search_model.dart';
import 'package:sportk/model/team_search_model.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/club/club_screen.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/search_field.dart';
import 'package:sportk/widgets/team_bubble.dart';

class SearchScreen extends StatefulWidget {
  final bool canAddToFav;

  const SearchScreen({
    super.key,
    this.canAddToFav = false,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late FootBallProvider _footBallProvider;
  late FavoriteProvider _favoriteProvider;
  late Future<List<dynamic>> _searchFuture;
  String? _query;
  Timer? _debounce;

  bool get _canAddToFav => widget.canAddToFav;

  _onSearchChanged(String? query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query == null || query.isEmpty) {
        setState(() {
          _query = null;
        });
      } else {
        _query = query;

        setState(() {
          _searchFuture = _initializeFutures(query);
        });
      }
    });
  }

  Future<List<dynamic>> _initializeFutures(String query) {
    final leagueSearchFuture = _footBallProvider.searchLeagues(query: query);
    final teamSearchFuture = _footBallProvider.searchTeams(query: query);
    final futures = [leagueSearchFuture, teamSearchFuture];
    if (!_canAddToFav) {
      final playersSearchFuture = _footBallProvider.searchPlayers(query: query);
      futures.add(playersSearchFuture);
    }
    return Future.wait(futures);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _favoriteProvider = context.favoriteProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchTextField(
          onChanged: _onSearchChanged,
          hintText: context.appLocalization.clubSearchHint,
        ),
      ),
      body: _query != null
          ? Consumer<FavoriteProvider>(
              builder: (context, provider, child) {
                return CustomFutureBuilder(
                    future: _searchFuture,
                    onRetry: () {
                      setState(() {
                        _searchFuture = _initializeFutures(_query!);
                      });
                    },
                    onComplete: (context, snapshot) {
                      final leagueModel = snapshot.data![0] as LeagueSearchModel;
                      final teamModel = snapshot.data![1] as TeamSearchModel;
                      PlayerSearchModel? playerModel;
                      if (!_canAddToFav) {
                        playerModel = snapshot.data![2] as PlayerSearchModel;
                      }
                      return ListView(
                        children: [
                          if (teamModel.data!.isNotEmpty) ...[
                            ListTile(
                              title: Text(context.appLocalization.teams),
                            ),
                            SizedBox(
                              height: 130,
                              child: ListView.separated(
                                itemCount: teamModel.data!.length,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                separatorBuilder: (context, index) => const SizedBox(width: 5),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final team = teamModel.data![index];
                                  final id = team.id!;
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return TeamBubble(
                                        team: team,
                                        onTap: () {
                                          if (_canAddToFav) {
                                            _favoriteProvider.toggleFavorites(
                                                id, CompoTypeEnum.teams, team.name!);
                                          } else {
                                            context.push(ClubScreen(teamId: id));
                                          }
                                        },
                                        selected: _favoriteProvider.isFav(id, CompoTypeEnum.teams),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                          if (playerModel != null && playerModel.data!.isNotEmpty) ...[
                            ListTile(
                              title: Text(context.appLocalization.players),
                            ),
                            SizedBox(
                              height: 130,
                              child: ListView.separated(
                                itemCount: playerModel.data!.length,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                separatorBuilder: (context, index) => const SizedBox(width: 5),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final player = playerModel!.data![index];
                                  final id = player.id!;
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomNetworkImage(
                                            player.imagePath!,
                                            height: 100,
                                            width: 100,
                                          ),
                                          Text(
                                            player.displayName!,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                          if (leagueModel.data!.isNotEmpty) ...[
                            ListTile(
                              title: Text(context.appLocalization.leagues),
                            ),
                            ListView.separated(
                              itemCount: leagueModel.data!.length,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => const SizedBox(height: 5),
                              itemBuilder: (context, index) {
                                final league = leagueModel.data![index];
                                final id = league.id!;
                                return LeagueTile(
                                  league: league,
                                  onTap: () {
                                    league.subType == LeagueTypeEnum.cubInternational
                                        ? context.push(
                                            ChampionsLeagueScreen(
                                              leagueId: id,
                                            ),
                                          )
                                        : context.push(
                                            LeagueInfoScreen(
                                              leagueId: league.id!,
                                              subType: league.subType!,
                                            ),
                                          );
                                    // context.push(
                                    //   LeagueInfoScreen(leagueId: id, subType: league.subType!),
                                    // );

                                    /// navigate to league info screen
                                  },
                                  trailing: _canAddToFav
                                      ? StatefulBuilder(
                                          builder: (context, setState) {
                                            return IconButton(
                                              onPressed: () {
                                                _favoriteProvider.toggleFavorites(
                                                    id, CompoTypeEnum.competitions, league.name!);
                                              },
                                              icon: CustomSvg(
                                                _favoriteProvider.isFav(
                                                        id, CompoTypeEnum.competitions)
                                                    ? MyIcons.starFilled
                                                    : MyIcons.starOutlined,
                                              ),
                                            );
                                          },
                                        )
                                      : null,
                                );
                              },
                            ),
                          ],
                        ],
                      );
                    });
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
