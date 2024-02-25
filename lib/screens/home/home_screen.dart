import 'package:flutter/material.dart';
import 'package:sportk/screens/home/widgets/home_bubble.dart';
import 'package:sportk/screens/home/widgets/live_switch.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLive = false;
  late DateTime _selectedDate;
  DateTime get _nowDate => DateTime.now();
  late Future<List<int>> _fetchCompetitionsFuture;
  final list = [
    8,
    564,
    82,
    72,
    301,
  ];

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _nowDate,
      lastDate: _nowDate.add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<List<int>> _initializeCompetitions() async {
    await Future.delayed(const Duration(seconds: 1));
    final ids = Future.value(list);
    return ids;
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = _nowDate;
    _fetchCompetitionsFuture = _initializeCompetitions();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _fetchCompetitionsFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeCompetitions();
        });
      },
      onError: (snapshot) => const SizedBox.shrink(),
      onComplete: (context, snapshot) {
        final competitions = snapshot.data!;
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
                    onPressed: () {},
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
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _showDatePicker(context);
                          },
                          icon: const CustomSvg(MyIcons.calender),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedDate = _selectedDate.add(const Duration(days: 1));
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
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
              // mina
              SliverPadding(
                padding: const EdgeInsets.all(20).copyWith(top: 0),
                sliver: SliverList.separated(
                  key: ValueKey(_selectedDate.microsecondsSinceEpoch),
                  itemCount: competitions.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final leagueId = competitions[index];
                    return HomeBubble(
                      date: _selectedDate,
                      leagueId: leagueId,
                    );
                  },
                ),
              ),
              // montk
            ],
          ),
        );
      },
    );
  }
}
