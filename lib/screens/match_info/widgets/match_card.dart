import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/screens/match_info/widgets/team_card.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 2,
          child: TeamCard(team: "Man uni"),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: context.colorPalette.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 64,
                        height: 30,
                        margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: context.colorPalette.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "6",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "Second half",
                        style: TextStyle(color: context.colorPalette.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 64,
                        height: 25,
                        decoration: BoxDecoration(
                          color: context.colorPalette.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colorPalette.red000,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.appLocalization.live,
                              style: TextStyle(color: context.colorPalette.blueD4B),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "1",
                    style: TextStyle(
                      color: context.colorPalette.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 2,
          child: TeamCard(team: "Man kljhkjhkjhkjhkjh"),
        ),
      ],
    );
  }
}
