import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_svg.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
  });
  final String icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvg(icon),
        Text(
          title,
          style: TextStyle(
            color: context.colorPalette.blueD4B,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorPalette.greyEAE,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: context.colorPalette.blueD4B,
            ),
          ),
        ),
      ],
    );
  }
}
