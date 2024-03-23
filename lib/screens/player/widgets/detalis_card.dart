import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';

class DetalisCard extends StatelessWidget {
  final String title;
  final String subTitle;

  const DetalisCard({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subTitle,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
