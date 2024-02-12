import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueScorers extends StatelessWidget {
  const LeagueScorers({super.key});

  @override
  Widget build(BuildContext context) {
    TableRow spacer = const TableRow(children: [
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 10,
      ),
    ]);
    final test = [
      {
        "nameplayer": "Lionel Messi",
        "team": "Man City",
        "goals": 22,
        "mPinalty": 0,
        "mGoals": 5,
      },
      {
        "nameplayer": "Lionel Messi",
        "team": "Man City",
        "goals": 22,
        "mPinalty": 0,
        "mGoals": 5,
      },
      {
        "nameplayer": "Lionel Messi",
        "team": "Man City",
        "goals": 22,
        "mPinalty": 0,
        "mGoals": 5,
      },
      {
        "nameplayer": "Lionel Messi",
        "team": "Man City",
        "goals": 22,
        "mPinalty": 0,
        "mGoals": 5,
      },
      {
        "nameplayer": "Lionel Messi",
        "team": "Man City",
        "goals": 22,
        "mPinalty": 0,
        "mGoals": 5,
      },
    ];

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.4),
            1: FlexColumnWidth(6.3),
            2: FlexColumnWidth(1.4),
            3: FlexColumnWidth(1.4),
            4: FlexColumnWidth(1.4),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: context.colorPalette.grey3F3,
                borderRadius: BorderRadius.circular(10),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    context.appLocalization.st,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    context.appLocalization.player,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    context.appLocalization.goals,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    context.appLocalization.goalsPenalty,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    context.appLocalization.missedPenalty,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            spacer,
            ...test.map((data) {
              return TableRow(
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Text(
                      (test.indexOf(data) + 1).toString(),
                      style: const TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        const CustomNetworkImage(
                          kFakeImage,
                          width: 35,
                          height: 35,
                          radius: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              data["nameplayer"].toString(),
                              style: const TextStyle(),
                            ),
                            Text(
                              data["team"].toString(),
                              style: TextStyle(fontSize: 11, color: context.colorPalette.blueD4B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      data["goals"].toString(),
                      style: TextStyle(fontSize: 11, color: context.colorPalette.blueD4B),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      data["mGoals"].toString(),
                      style: const TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      data["mPinalty"].toString(),
                      style: const TextStyle(),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
