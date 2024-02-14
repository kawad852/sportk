import 'package:flutter/material.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/statistics_card.dart';
import 'package:sportk/screens/player/widgets/line_divider.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerStatistics extends StatefulWidget {
  const PlayerStatistics({super.key});

  @override
  State<PlayerStatistics> createState() => _PlayerStatisticsState();
}

class _PlayerStatisticsState extends State<PlayerStatistics> {
  int selectedIndex = 0;
  late Future<List<dynamic>> _futures;

  Future<List<dynamic>> _initlaizeFutures() async {
    final f1 = method1();
    final id = await f1;
    final f2 = method2(id);
    return Future.wait([f1, f2]);
  }

  Future<String> method2(int id) {
    return Future.value("mhyar id is $id");
  }

  Future<int> method1() {
    return Future.value(1999);
  }

  @override
  void initState() {
    super.initState();
    _futures = _initlaizeFutures();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
        future: _futures,
        onRetry: () {
          setState(() {
            _futures = _initlaizeFutures();
          });
        },
        onComplete: (context, snapshot) {
          final dat1 = snapshot.data![0] as int;
          final data2 = snapshot.data![1] as String;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dat1.toString()),
              Text(data2),
              Text(
                context.appLocalization.statistics,
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 35.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          height: 30,
                          margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? context.colorPalette.blueABB
                                : context.colorPalette.greyEAE,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
                            child: Row(
                              children: [
                                const CustomNetworkImage(
                                  kFakeImage,
                                  width: 20,
                                  height: 20,
                                  radius: 0,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Premier League",
                                  style: TextStyle(
                                    color: context.colorPalette.blueD4B,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 15, top: 15),
                child: Container(
                  height: 128,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorPalette.grey3F3,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatisticsCard(
                          icon: MyIcons.goals,
                          title: context.appLocalization.goals,
                          text: "9",
                        ),
                        const LineDivider(),
                        StatisticsCard(
                          icon: MyIcons.yellowCard,
                          title: context.appLocalization.yellowCard,
                          text: "9",
                        ),
                        const LineDivider(),
                        StatisticsCard(
                          icon: MyIcons.redCard,
                          title: context.appLocalization.redCard,
                          text: "9",
                        ),
                        const LineDivider(),
                        StatisticsCard(
                          icon: MyIcons.assist,
                          title: context.appLocalization.assist,
                          text: "50",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
