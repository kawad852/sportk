import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class CouponsCard extends StatefulWidget {
  const CouponsCard({super.key});

  @override
  State<CouponsCard> createState() => _CouponsCardState();
}

class _CouponsCardState extends State<CouponsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: context.colorPalette.grey2F2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            CustomNetworkImage(
              kFakeImage,
              width: 130,
              height: 114,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25.0,
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.colorPalette.grey2F2,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "1400",
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const CustomSvg(
                                MyIcons.coin,
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.colorPalette.grey2F2,
                        ),
                        child: Column(
                          children: [
                            Text(
                              context.appLocalization.winners,
                              style: TextStyle(
                                color: context.colorPalette.blueD4B,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              "121",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              "Shahid subscription for one month",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
