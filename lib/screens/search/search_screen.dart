import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/league_search_model.dart';
import 'package:sportk/model/team_search_model.dart';
import 'package:sportk/providers/favorite_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/search_field.dart';
import 'package:sportk/widgets/team_bubble.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
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
    return Future.wait([leagueSearchFuture, teamSearchFuture]);
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
                                          _favoriteProvider.toggleFavorites(id, CompoTypeEnum.teams);
                                        },
                                        selected: _favoriteProvider.isFav(id, CompoTypeEnum.teams),
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
                                  onTap: () {},
                                  trailing: StatefulBuilder(
                                    builder: (context, setState) {
                                      return IconButton(
                                        onPressed: () {
                                          _favoriteProvider.toggleFavorites(id, CompoTypeEnum.competitions);
                                        },
                                        icon: CustomSvg(
                                          _favoriteProvider.isFav(id, CompoTypeEnum.competitions) ? MyIcons.starFilled : MyIcons.starOutlined,
                                        ),
                                      );
                                    },
                                  ),
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
