import 'package:flutter/material.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class ClubStandings extends StatefulWidget {
  const ClubStandings({super.key});

  @override
  State<ClubStandings> createState() => _ClubStandingsState();
}

class _ClubStandingsState extends State<ClubStandings> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8, start: 10, bottom: 8),
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
          const LeagueStandings(leagueId: 564),
        ],
      ),
    );
  }
}
