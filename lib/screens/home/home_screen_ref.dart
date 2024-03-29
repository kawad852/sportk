import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/main_matches_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/home/widgets/arrow_button.dart';
import 'package:sportk/screens/home/widgets/live_switch.dart';
import 'package:sportk/screens/notifications/notifications_screen.dart';
import 'package:sportk/screens/profile/profile_screen.dart';
import 'package:sportk/screens/search/search_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/web_view_screen.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/match_timer_circle.dart';

class HomeScreenRef extends StatefulWidget {
  const HomeScreenRef({super.key});

  @override
  State<HomeScreenRef> createState() => _HomeScreenRefState();
}

class _HomeScreenRefState extends State<HomeScreenRef> {
  late CommonProvider _commonProvider;
  bool _isLive = false;
  late DateTime _selectedDate;

  DateTime get _nowDate => DateTime.now();

  int get _maxDuration => 30;

  DateTime get _minDate => _nowDate.subtract(Duration(days: _maxDuration));

  DateTime get _maxDate => _nowDate.add(Duration(days: _maxDuration));

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

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _selectedDate = _nowDate;
    _commonProvider.initializeHome(context, date: _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _commonProvider.leaguesAndLivesFutures,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _commonProvider.initializeHome(context, date: _selectedDate);
        });
      },
      onComplete: (context, snapshot) {
        final livesModel = snapshot.data![0] as LivesMatchesModel;
        final mainMatchesModel = snapshot.data![1] as MainMatchesModel;
        final leagueIds = mainMatchesModel.data!.map((e) => e.leagueId!).toSet().toList();
        final matches = mainMatchesModel.data!.where((element) => leagueIds.contains(element.leagueId)).toList();
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
                    leading: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const CustomSvg(MyIcons.menu),
                    ),
                    title: Text(
                      _selectedDate.formatDate(context, pattern: 'EEE, MMM d'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList.separated(
                        itemCount: leagueIds.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          final league = matches[index].league!;
                          return Column(
                            children: [
                              LeagueTile(
                                league: league,
                                onTap: () {
                                  UiHelper.navigateToLeagueInfo(
                                    context,
                                    leagueData: league,
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
                                  return StatefulBuilder(builder: (context, setState) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.push(WebViewScreen(matchId: match.id!));
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
                                                      match.state!.id != 1 && match.state!.id != 13 && match.state!.id != 10
                                                          ? Text(
                                                              "$homeGoals",
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15,
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
                                                                        match.state!.name!,
                                                                        textAlign: TextAlign.center,
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          color: context.colorPalette.green057,
                                                                          fontSize: 10,
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (match.state!.id == 1)
                                                                      Text(
                                                                        match.startingAt!.formatDate(context, pattern: 'HH:mm'),
                                                                        style: const TextStyle(
                                                                          fontSize: 8,
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                      match.state!.id != 1 && match.state!.id != 13 && match.state!.id != 10
                                                          ? Text(
                                                              "$awayGoals",
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15,
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
                                  });
                                },
                              ),
                            ],
                          );
                        },
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
}
