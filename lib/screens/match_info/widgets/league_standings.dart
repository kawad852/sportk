import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueStandings extends StatelessWidget {
  const LeagueStandings({super.key});

  @override
  Widget build(BuildContext context) {
    //test
    final matchInfo = [
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man United",
        "play": "21",
        "w": "18",
        "d": "20",
        "l": "1",
        "goal": "38:12",
        "dif": "3",
        "points": "56",
      },
      {
        "team": "Man Unitedfffffmmmmmmm",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "10",
        "goal": "38:120",
        "dif": "30",
        "points": "56",
      },
      {
        "team": "Man Unitedfffffmmmmmmm",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "10",
        "goal": "38:120",
        "dif": "30",
        "points": "56",
      },
      {
        "team": "Man Unitedfffffmmmmmmm",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "10",
        "goal": "38:120",
        "dif": "30",
        "points": "56",
      },
      {
        "team": "Man Unitedfffffmmmmmmm",
        "play": "21",
        "w": "18",
        "d": "2",
        "l": "10",
        "goal": "38:120",
        "dif": "30",
        "points": "100",
      },
    ];
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(6.3),
          1: FlexColumnWidth(1.4),
          2: FlexColumnWidth(1.4),
          3: FlexColumnWidth(1.4),
          4: FlexColumnWidth(1.4),
          5: FlexColumnWidth(2.8),
          6: FlexColumnWidth(1.5),
          7: FlexColumnWidth(1.8),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: context.colorPalette.greyD9D,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            children: [
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text("S",
              //       style: TextStyle(
              //         fontSize: 12,
              //       )),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  context.appLocalization.team,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.play,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.winner,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.draw,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.loser,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.goals,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.differance,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  //textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  context.appLocalization.points,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ...matchInfo.map((data) {
            return TableRow(
              decoration: BoxDecoration(
                color: matchInfo.indexOf(data) == 1 || matchInfo.indexOf(data) == 3
                    ? context.colorPalette.blueABB
                    : matchInfo.indexOf(data) % 2 == 0
                        ? context.colorPalette.grey3F3
                        : context.colorPalette.greyD9D,
                borderRadius: matchInfo.indexOf(data) == matchInfo.length - 1
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : null,
              ),
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     (matchInfo.indexOf(data) + 1).toString(),
                //     style: const TextStyle(
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        (matchInfo.indexOf(data) + 1).toString(),
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: CustomNetworkImage(
                          kFakeImage,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          data["team"]!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["play"]!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["w"]!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["d"]!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["l"]!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["goal"]!,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["dif"]!,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    data["points"]!,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
