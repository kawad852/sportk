import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class ChampionshipsCard extends StatelessWidget {
  const ChampionshipsCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> test = [
      {
        "type": "Local",
        "list": [
          {
            "name": "Bundesliga",
          },
          {
            "name": "Bundesliga",
          },
          {
            "name": "Bundesliga",
          },
        ],
      },
      {
        "type": "Local",
        "list": [
          {
            "name": "Bundesliga",
          },
          {
            "name": "Bundesliga",
          },
          {
            "name": "Bundesliga",
          },
        ],
      },
      {
        "type": "Local",
        "list": [
          {
            "name": "Bundesliga",
          },
          {
            "name": "Bundesliga",
          },
          {
            "name": "Bundesliga",
          },
        ],
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          test[index]["type"],
          style: TextStyle(
            color: context.colorPalette.blueD4B,
            fontWeight: FontWeight.w600,
          ),
        ),
        ...test[index]["list"].map(
          (data) {
            return Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: context.colorPalette.grey2F2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CustomNetworkImage(
                          kFakeImage,
                          width: 20,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data["name"],
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: context.colorPalette.blueD4B,
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
//fff
