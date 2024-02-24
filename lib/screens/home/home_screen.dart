import 'package:flutter/material.dart';
import 'package:sportk/screens/home/widgets/home_bubble.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

import '../news/news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<int>> _fetchCompetitionsFuture;
  final list = [
    8,
    564,
    82,
    72,
    301,
  ];

  Future<List<int>> _initializeCompetitions() async {
    await Future.delayed(const Duration(seconds: 1));
    final ids = Future.value(list);
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
              // mina
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
                        ListTile(
                          onTap: () {
                            // context.push(const LeagueScreen());
                          },
                          dense: true,
                          tileColor: context.colorPalette.grey2F2,
                          leading: const CustomNetworkImage(
                            kFakeImage,
                            radius: 0,
                            width: 25,
                            height: 25,
                          ),
                          title: const Text(
                            'Team Name',
                            overflow: TextOverflow.ellipsis,
                          ),
                          // trailing: widget.trailing,
                        ),
                        HomeBubble(date: DateTime.now(), leagueId: competition),
                      ],
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
