import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sportk/model/league_search_model.dart';
import 'package:sportk/model/team_search_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  final List<int> selectedLeagues;
  final List<int> selectedTeams;

  const SearchScreen({
    super.key,
    required this.selectedLeagues,
    required this.selectedTeams,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late FootBallProvider _footBallProvider;
  late Future<List<dynamic>> _searchFuture;
  String? _query;
  Timer? _debounce;

  late List<int> _selectedLeagues;
  late List<int> _selectedTeams;

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
    _selectedLeagues = widget.selectedLeagues;
    _selectedTeams = widget.selectedTeams;
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
          ? CustomFutureBuilder(
              future: _searchFuture,
              onRetry: () {
                setState(() {
                  _searchFuture = _initializeFutures(_query!);
                });
              },
              onComplete: (context, snapshot) {
                final leagueModel = snapshot.data![0] as LeagueSearchModel;
                final teamModel = snapshot.data![1] as TeamSearchModel;
                return Column(
                  children: [
                    ListTile(
                      title: Text("Leagues"),
                    ),
                    ListView.separated(
                      itemCount: leagueModel.data!.length,
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        final league = leagueModel.data![index];
                        final id = league.id!;
                        return LeagueTile(
                          league: league,
                          onTap: () {},
                          selectedTeams: _selectedTeams,
                          trailing: StatefulBuilder(
                            builder: (context, setState) {
                              return IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_selectedLeagues.contains(id)) {
                                      _selectedLeagues.remove(id);
                                    } else {
                                      _selectedLeagues.add(id);
                                    }
                                  });
                                },
                                icon: CustomSvg(
                                  _selectedLeagues.contains(id) ? MyIcons.starFilled : MyIcons.starOutlined,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              })
          : const SizedBox.shrink(),
    );
  }
}
