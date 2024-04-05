import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/favorite_model.dart';
import 'package:sportk/model/home_competitions_model.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/home/widgets/arrow_button.dart';
import 'package:sportk/screens/home/widgets/live_switch.dart';
import 'package:sportk/screens/notifications/notifications_screen.dart';
import 'package:sportk/screens/profile/profile_screen.dart';
import 'package:sportk/screens/search/search_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/match_timer_circle.dart';
import 'package:sportk/widgets/menu_button.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late CommonProvider _commonProvider;
  late FootBallProvider _footBallProvider;
  bool _isLive = false;
  late DateTime _selectedDate;

  DateTime get _nowDate => DateTime.now();

  int get _maxDuration => 30;

  DateTime get _minDate => _nowDate.subtract(Duration(days: _maxDuration));

  DateTime get _maxDate => _nowDate.add(Duration(days: _maxDuration));

  List<int> get _liveStateIds => [2, 3, 4, 6, 9, 22, 25];

  List<int> get _showGoals => [1,13,10,11,12,14,15,16,17,19,20,21,26];

  String _formattedDate(BuildContext context) => _selectedDate.formatDate(context, pattern: 'EEE, MMM d');

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _minDate,
      lastDate: _maxDate,
    );
    if (picked != null) {
      _onDateChanged(picked);
    }
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  bool _reachedMaxDate(DateTime targetDate) {
    final selected = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    if (selected.isAtSameMomentAs(target)) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> _initializeFutures(int fId, String type) async {
    late int leagueId;
    late Future<LeagueModel> leagueFuture;
    late Future<LeagueByDateModel> teamsFuture;
    if (type == CompoTypeEnum.teams) {
      final leagueByTeamFuture = _footBallProvider.fetchLeagueByTeam(context, _selectedDate, fId);
      final team = await leagueByTeamFuture;
      final id = team.data!.first.leagueId!;
      leagueId = id;
    } else {
      leagueId = fId;
    }
    leagueFuture = _footBallProvider.fetchLeague(leagueId: leagueId);
    teamsFuture = _footBallProvider.fetchLeagueByDate(_selectedDate, leagueId);
    return Future.wait([leagueFuture, teamsFuture]);
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _footBallProvider = context.footBallProvider;
    _selectedDate = _nowDate;
    _commonProvider.initializeHome(context, date: _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder(
      future: _commonProvider.leaguesAndLivesFutures,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _commonProvider.initializeHome(context, date: _selectedDate);
        });
      },
      onComplete: (context, snapshot) {
        final leaguesModel = snapshot.data![0] as HomeCompetitionsModel;

        final competitions = leaguesModel.competitions as List<String>;
        List<FavoriteData> allCompetitions = competitions.map((e) => FavoriteData(favoritableId: int.parse(e), type: CompoTypeEnum.competitions)).toList();
        return Scaffold(
          drawer: const ProfileScreen(),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar.medium(
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    leading: const MenuButton(),
                    title: Text(
                      _formattedDate(context),
                      style: context.textTheme.labelLarge,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.push(const NotificationsScreen());
                        },
                        icon: const CustomSvg(MyIcons.bell),
                      ),
                      IconButton(
                        onPressed: () {
                          context.push(const SearchScreen());
                        },
                        icon: const CustomSvg(MyIcons.search),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          iconButtonTheme: const IconButtonThemeData(
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: MaterialStatePropertyAll(EdgeInsets.zero),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ArrowButton(
                              iconData: Icons.arrow_back_ios,
                              onTap: _reachedMaxDate(_minDate)
                                  ? null
                                  : () {
                                      _onDateChanged(_selectedDate.subtract(const Duration(days: 1)));
                                    },
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                _showDatePicker(context);
                              },
                              icon: const CustomSvg(MyIcons.calender),
                            ),
                            ArrowButton(
                              iconData: Icons.arrow_forward_ios,
                              onTap: _reachedMaxDate(_maxDate)
                                  ? null
                                  : () {
                                      _onDateChanged(_selectedDate.add(const Duration(days: 1)));
                                    },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      LiveSwitch(
                        active: _isLive,
                        onTap: () {
                          setState(() {
                            _isLive = !_isLive;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _isLive = value;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ];
            },
            body: Builder(
              builder: (context) {
                return CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                    SliverPadding(
                      padding: const EdgeInsets.all(20).copyWith(top: 0),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          key: ValueKey('${_selectedDate.microsecondsSinceEpoch}$_isLive'),
                          children: List.generate(
                            allCompetitions.length,
                            (index) {
                              final competition = allCompetitions[index];
                              if (competition.date != _selectedDate) {
                                competition.date = _selectedDate;
                                competition.futures = null;
                                competition.futures = _initializeFutures(competition.favoritableId!, competition.type!);
                              }
                              return CustomFutureBuilder(
                                key: ValueKey(index),
                                future: competition.futures!,
                                onRetry: () {},
                                onLoading: () {
                                  return ShimmerLoading(
                                    child: Column(
                                      children: [
                                        const LoadingBubble(
                                          height: 50,
                                          margin: EdgeInsets.only(bottom: 5),
                                          radius: MyTheme.radiusPrimary,
                                        ),
                                        ListView.separated(
                                          itemCount: 20,
                                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return const LoadingBubble(
                                              height: 65,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                onError: (snapshot) {
                                  return const SizedBox.shrink();
                                },
                                onComplete: (context, snapshot) {
                                  final leagueModel = snapshot.data![0] as LeagueModel;
                                  final matchModel = snapshot.data![1] as LeagueByDateModel;
                                  List<MatchData> matches = [];
                                  if (_isLive) {
                                    matches = matchModel.data!.where((element) {
                                      final stateId = element.state?.id;
                                      return _liveStateIds.contains(stateId);
                                    }).toList();
                                  } else {
                                    matches = matchModel.data!;
                                  }

                                  if (matches.isEmpty) {
                                    competition.hasMatches = false;
                                    if (allCompetitions.every((element) => !element.hasMatches)) {
                                      return NoResults(
                                        header: const Icon(FontAwesomeIcons.trophy),
                                        title: _isLive ? context.appLocalization.homeEmptyLiveMatchesTitle : context.appLocalization.homeEmptyMatchesTitle(_formattedDate(context)),
                                        body: _isLive ? '' : context.appLocalization.homeEmptyMatchesBody,
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }
                                  final matchesCompetitions = allCompetitions.where((element) => element.hasMatches).toList();
                                  print("akejfhaejkfhaejkfh:::: ${matchesCompetitions.length % index}");
                                  return Column(
                                    children: [
                                      LeagueTile(
                                        league: leagueModel.data!,
                                        onTap: () {
                                          UiHelper.navigateToLeagueInfo(
                                            context,
                                            leagueData: leagueModel.data!,
                                          );
                                        },
                                      ),
                                      ListView.separated(
                                        itemCount: matches.length,
                                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final match = matches[index];
                                          int homeGoals = 0;
                                          int awayGoals = 0;
                                          int? minute;
                                          int? timeAdded;
                                          List<double> goalsTime = [];
                                          Participant teamHome = Participant();
                                          Participant teamAway = Participant();
                                          match.participants!.map((e) {
                                            if (e.meta!.location == LocationEnum.home) {
                                              teamHome = e;
                                            } else {
                                              teamAway = e;
                                            }
                                          }).toSet();
                                          match.periods!.map((period) {
                                            if (period.hasTimer! && (period.typeId == 2 || period.typeId == 1)) {
                                              minute = period.minutes;
                                              timeAdded = period.timeAdded;
                                            } else if (period.hasTimer! && period.typeId == 3) {
                                              minute = period.minutes;
                                              timeAdded = period.timeAdded == null ? 30 : 30 + period.timeAdded!;
                                            }
                                            period.events!.map((event) {
                                              if (event.typeId == 14 || event.typeId == 16) {
                                                goalsTime.add(event.minute!.toDouble());
                                              }
                                            }).toSet();
                                          }).toSet();
                                          match.statistics!.map(
                                            (e) {
                                              if (e.typeId == 52) {
                                                switch (e.location) {
                                                  case LocationEnum.home:
                                                    homeGoals = e.data!.value!;
                                                  case LocationEnum.away:
                                                    awayGoals = e.data!.value!;
                                                }
                                              }
                                            },
                                          ).toSet();
                                          return GestureDetector(
                                            onTap: () {
                                              log(match.id.toString());
                                              UiHelper.navigateToMatchInfo(
                                                context,
                                                matchId: match.id!,
                                                leagueId: match.leagueId!,
                                                subType: match.league!.subType!,
                                                commonProvider: _commonProvider,
                                                afterNavigate: () {
                                                  setState(() {
                                                    // _futures = _initializeFutures();
                                                  });
                                                },
                                              );
                                            },
                                            child: Builder(
                                              builder: (context) {
                                                return Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                    color: context.colorPalette.homeMatchBubble,
                                                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                                                    border: Border.all(color: context.colorPalette.grey0F5),
                                                  ),
                                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          teamHome.name!,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: context.colorPalette.blueD4B,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      CustomNetworkImage(
                                                        teamHome.imagePath!,
                                                        width: 30,
                                                        height: 30,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                             ! _showGoals.contains(match.state!.id!)?
                                                                 Text(
                                                                    "$homeGoals",
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 16,
                                                                    ),
                                                                  )
                                                                : const SizedBox(
                                                                    width: 6,
                                                                  ),
                                                            match.state!.id == 3
                                                                ? Padding(
                                                                    padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                                                                    child: MatchTimerCircle(
                                                                      currentTime: 45,
                                                                      goalsTime: goalsTime,
                                                                      timeAdded: 0,
                                                                      isHalfTime: true,
                                                                    ),
                                                                  )
                                                                : minute != null
                                                                    ? Padding(
                                                                        padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                                                                        child: MatchTimerCircle(
                                                                          currentTime: minute!.toDouble(),
                                                                          goalsTime: goalsTime,
                                                                          timeAdded: timeAdded,
                                                                        ),
                                                                      )
                                                                    : Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 55,
                                                                            child: Text(
                                                                              UiHelper.getMatchState(
                                                                                context,
                                                                                stateId: match.state!.id!,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                              maxLines: 3,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                color: context.colorPalette.green057,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (match.state!.id == 1)
                                                                            Text(
                                                                              DateFormat("HH:mm").format(match.startingAt!),
                                                                              style: const TextStyle(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                            ! _showGoals.contains(match.state!.id!)?
                                                                 Text(
                                                                    "$awayGoals",
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 16,
                                                                    ),
                                                                  )
                                                                : const SizedBox(
                                                                    width: 6,
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      CustomNetworkImage(
                                                        teamAway.imagePath!,
                                                        width: 30,
                                                        height: 30,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          teamAway.name!,
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            color: context.colorPalette.blueD4B,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      // if (competition.hasMatches && (index % 3 == 0))
                                      if (index % 4 == 0)
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: GoogleBanner(
                                            adSize: AdSize.largeBanner,
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
