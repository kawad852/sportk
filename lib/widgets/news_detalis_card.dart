import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class NewsDetalisCard extends StatelessWidget {
  const NewsDetalisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomNetworkImage(
          kFakeImage,
          radius: 10,
          width: 350,
          height: 200,
        ),
        const SizedBox(
          height: 5,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "12/12/2023",
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "9:41",
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 5,
            ),
            CustomSvg(MyIcons.clock)
          ],
        ),
        Text(
          "بعد اصابته... أخبار سيئة بشأن نيمار",
          style: TextStyle(
            color: context.colorPalette.blueD4B,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          " وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف ر وصف وصف وصف وصف وصف وصف وصف وصف وصف",
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorPalette.blueD4B,
              fixedSize: const Size(350, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              "قراءة الخبر من المصدر",
              style: TextStyle(color: context.colorPalette.white),
            ))
      ],
    );
  }
}
