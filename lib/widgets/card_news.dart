import 'package:flutter/material.dart';
import 'package:sportk/screens/news_detalis/news_detalis_screen.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class CardNews extends StatelessWidget {
  const CardNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: context.colorPalette.grey3F3,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsetsDirectional.all(8.0),
        width: 280.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CustomNetworkImage(
                kFakeImage,
                onTap: () {
                  context.push(const NewsDetalisScreen());
                },
                radius: 0,
                width: 280,
                height: 153,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "تشيلسي يوافق على بيع قائده بسبب قواعد اللعب المالي النظيف",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const CustomNetworkImage(
                        kFakeImage,
                        radius: 5,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "هاي كورة - 01-01-2024",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.colorPalette.blueD4B,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Container(
                  color: context.colorPalette.grey3F,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const CustomSvg(
                              MyIcons.heart,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "1.3k",
                            style:
                                TextStyle(color: context.colorPalette.red000),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const CustomSvg(
                          MyIcons.download,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
