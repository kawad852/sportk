import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueCard extends StatelessWidget {
  const LeagueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsetsDirectional.all(6.0),
          decoration: BoxDecoration(
            color: context.colorPalette.grey9E9,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: CustomNetworkImage(
              kFakeImage,
              radius: 0,
              width: 60,
              height: 60,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 6, end: 6),
          width: 80,
          child: Text(
            "Premier League",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: context.colorPalette.blueD4B,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
