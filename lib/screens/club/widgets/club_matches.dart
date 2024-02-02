import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class ClubMatches extends StatefulWidget {
  const ClubMatches({super.key});

  @override
  State<ClubMatches> createState() => _ClubMatchesState();
}

class _ClubMatchesState extends State<ClubMatches> {
  final test = [
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
    {
      "title": "Premier League- week 22",
      "team1": "Man United",
      "team2": "Man City",
      "date": "05/01/2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.appLocalization.nextMatches,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ...test.map(
              (data) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 35,
                      margin: const EdgeInsetsDirectional.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: context.colorPalette.greyEAE,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 8, end: 5),
                            child: CustomNetworkImage(
                              kFakeImage,
                              width: 20,
                              height: 20,
                              radius: 0,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              data["title"]!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: context.colorPalette.blueD4B,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      margin: const EdgeInsetsDirectional.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: context.colorPalette.blueE2F,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              data["team1"]!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const CustomNetworkImage(
                            kFakeImage,
                            width: 30,
                            height: 30,
                            radius: 0,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
                            child: Text(
                              data['date']!,
                              style: TextStyle(
                                color: context.colorPalette.green057,
                                fontSize: 8,
                              ),
                            ),
                          ),
                          const CustomNetworkImage(
                            kFakeImage,
                            width: 30,
                            height: 30,
                            radius: 0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              data["team2"]!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
