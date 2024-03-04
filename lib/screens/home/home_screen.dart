import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportk/model/favorite_model.dart';
import 'package:sportk/model/home_competitions_model.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/home/widgets/arrow_button.dart';
import 'package:sportk/screens/home/widgets/home_bubble.dart';
import 'package:sportk/screens/home/widgets/live_switch.dart';
import 'package:sportk/screens/search/search_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CommonProvider _commonProvider;
  late FootBallProvider _footBallProvider;
  bool _isLive = false;
  late DateTime _selectedDate;
  // final _showMsg = false;
  var msgs = <bool>[];

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
      msgs = [];
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
    _footBallProvider = context.footBallProvider;
    _selectedDate = _nowDate;
    _commonProvider.initializeHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _commonProvider.leaguesAndLivesFutures,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _commonProvider.initializeHome(context);
        });
      },
      onComplete: (context, snapshot) {
        final favorites = snapshot.data![0] as FavoriteModel;
        final competitions = snapshot.data![1] as HomeCompetitionsModel;
        final lives = snapshot.data![2] as LivesMatchesModel;
        _footBallProvider.competitionIds = [];
        List<FavoriteData> allCompetitions = [...favorites.data!, ...competitions.competitions!.map((e) => FavoriteData(favoritableId: int.parse(e), type: CompoTypeEnum.competitions)).toList()];
        if (_isLive) {
          final liveIds = lives.data!.map((e) => e.competitionId).toList();
          allCompetitions = allCompetitions.where((element) => liveIds.contains('${element.favoritableId}')).toList();
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                pinned: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: const CustomSvg(MyIcons.menu),
                ),
                title: Text(
                  _selectedDate.formatDate(context, pattern: 'EEE, MMM d'),
                  style: context.textTheme.labelLarge,
                ),
                actions: [
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
              // SliverToBoxAdapter(
              //   child: Center(
              //     child: Padding(
              //       padding: const EdgeInsets.all(100),
              //       child: ClockCircles(
              //         circleRadius: 60,
              //         numberOfCircles: 9,
              //         circleSpacing: 5,
              //         circleColor: Colors.blue,
              //         smallCircleRadius: 5,
              //         smallCircleColor: Colors.red,
              //         startSide: StartSide.right,
              //       ),
              //     ),
              //   ),
              // ),
              Consumer<FootBallProvider>(
                builder: (context, provider, child) {
                  if (msgs.isNotEmpty && msgs.every((element) => true)) {
                    return SliverToBoxAdapter(
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text("Empty"),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.all(20).copyWith(top: 0),
                    sliver: SliverList.builder(
                      key: ValueKey('${_selectedDate.microsecondsSinceEpoch}$_isLive'),
                      itemCount: allCompetitions.length,
                      // separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemBuilder: (context, index) {
                        final competition = allCompetitions[index];
                        final liveLeagues = lives.data!.where((element) => element.competitionId == '${competition.favoritableId}').toList();
                        return HomeBubble(
                          date: _selectedDate,
                          id: competition.favoritableId!,
                          type: competition.type!,
                          lives: liveLeagues,
                          isLive: _isLive,
                          index: index,
                          length: allCompetitions.length,
                          callBack: (bool value) {
                            // msgs.add(value);
                            // if (index + 1 == allCompetitions.length) {
                            //   Future.microtask(() {
                            //     setState(() {});
                            //   });
                            //   print("masjabf::: $msgs");
                            // }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
