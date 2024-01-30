import 'package:flutter/material.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key, required this.player});
  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const CustomNetworkImage(
                  kFakeImage,
                  width: 30,
                  height: 30,
                  radius: 0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 25, start: 5),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: context.colorPalette.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "9",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
              child: Column(
                children: [
                  CustomNetworkImage(
                    player.results![0].logo!,
                    width: 60,
                    height: 60,
                    radius: 5,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                const CustomNetworkImage(
                  kFakeImage,
                  width: 30,
                  height: 30,
                  radius: 0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 25, start: 5),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: context.colorPalette.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "9",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          player.results![0].name!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: context.colorPalette.blueD4B),
        ),
        Text(
          "Team",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: context.colorPalette.blueD4B),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.results![0].positions![0] ?? "",
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        context.appLocalization.position,
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${player.results![0].age!} ${context.appLocalization.year}",
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        context.appLocalization.age,
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${player.results![0].weight!} ${context.appLocalization.kg}",
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        context.appLocalization.weight,
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${player.results![0].height!} ${context.appLocalization.cm}",
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        context.appLocalization.height,
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
