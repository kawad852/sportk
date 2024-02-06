import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class ClubPlayers extends StatefulWidget {
  const ClubPlayers({super.key});

  @override
  State<ClubPlayers> createState() => _ClubPlayersState();
}

class _ClubPlayersState extends State<ClubPlayers> {
  final test = [
    {
      "list": [
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
      ]
    },
    {
      "list": [
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
      ]
    },
    {
      "list": [
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
      ]
    },
    {
      "list": [
        {
          "name": "L.Messi",
          "number": 9,
        },
        {
          "name": "L.Messi",
          "number": 9,
        },
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<String> players = [
      context.appLocalization.attackers,
      context.appLocalization.midline,
      context.appLocalization.defenders,
      context.appLocalization.guards
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30.0,
                  margin: const EdgeInsetsDirectional.only(bottom: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.colorPalette.greyEAE,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    players[index],
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: test[index]["list"]!.length,
                  itemBuilder: (BuildContext context, int myIndex) {
                    return Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: const EdgeInsetsDirectional.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: context.colorPalette.grey3F3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CustomNetworkImage(
                                  kFakeImage,
                                  width: 35.0,
                                  height: 35.0,
                                  radius: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    test[index]["list"]![myIndex]["name"].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorPalette.grey9E9,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                test[index]["list"]![myIndex]["number"].toString(),
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
