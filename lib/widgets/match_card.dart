import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/team_card.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 2,
          child: TeamCard(),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "2",
                    style: TextStyle(
                      color: context.colorPalette.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                    child: Container(
                      width: 64,
                      height: 30,
                      decoration: BoxDecoration(
                        color: context.colorPalette.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "60",
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "1",
                    style: TextStyle(
                      color: context.colorPalette.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
        ),
        const Expanded(
          flex: 2,
          child: TeamCard(),
        ),
      ],
    );
  }
}
