import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

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
          width: double.infinity,
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
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 5,
                end: 5,
              ),
              child: Text(
                "9:41",
                style: TextStyle(fontSize: 10),
              ),
            ),
            CustomSvg(MyIcons.clock),
          ],
        ),
        Text(
          "بعد اصابته... أخبار سيئة بشأن نيمار",
          style: TextStyle(
            color: context.colorPalette.blueD4B,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 15, bottom: 15),
          child: Text(
            " وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف ر وصف وصف وصف وصف وصف وصف وصف وصف وصف",
          ),
        ),
        StretchedButton(
          onPressed: () {},
          child: Text(
            "قراءة الخبر من المصدر",
            style: TextStyle(color: context.colorPalette.white),
          ),
        ),
      ],
    );
  }
}
