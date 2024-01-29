import 'package:flutter/material.dart';
import 'package:sportk/screens/home/widgets/teams_tile.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/stretch_button.dart';

import '../news/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> _fetchCompetitionsFuture;

  Future<List<String>> _initializeCompetitions() async {
    // final data = ApiService<ScheduleAndResultsModel>().build(
    //   sportsUrl: ApiUrl.scheduleAndResults,
    //   isPublic: true,
    //   apiType: ApiType.get,
    //   builder: ScheduleAndResultsModel.fromJson,
    // );
    await Future.delayed(const Duration(seconds: 1));
    final ids = Future.value(['jednm9whz0ryox8']);
    return ids;
  }

  @override
  void initState() {
    super.initState();
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
          bottomNavigationBar: BottomAppBar(
            child: StretchedButton(
              child: const Text("Save"),
              onPressed: () {},
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: const CustomSvg(MyIcons.menu),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.push(const NewsScreen());
                    },
                    icon: const CustomSvg(MyIcons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const CustomSvg(MyIcons.calender),
                  ),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                  child: Text(
                    "Tuesday 12-12-2024",
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList.separated(
                  itemCount: competitions.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final competition = competitions[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LeagueTile(competitionId: competition),
                        TeamsTile(
                          competitionId: competition,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
