import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_svg.dart';

class PredictionsCard extends StatelessWidget {
  final String predictionText;
  const PredictionsCard({super.key, required this.predictionText});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        width: double.infinity,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: context.colorPalette.yellowF7A20,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomSvg(
              MyIcons.coin,
              fixedColor: true,
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                predictionText,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
