import 'dart:math';

import 'package:flutter/material.dart';

class ClockCircles extends StatelessWidget {
  final double circleRadius;
  final int numberOfCircles;
  final double circleSpacing;
  final Color circleColor;
  final double smallCircleRadius;
  final Color smallCircleColor;

  const ClockCircles({
    Key? key,
    required this.circleRadius,
    required this.numberOfCircles,
    required this.circleSpacing,
    required this.circleColor,
    required this.smallCircleRadius,
    required this.smallCircleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> smallCircles = [];
    final double angle = 2 * pi / numberOfCircles;
    for (int i = 0; i < numberOfCircles; i++) {
      final double x = circleRadius * cos(i * angle);
      final double y = circleRadius * sin(i * angle);
      smallCircles.add(
        Positioned(
          left: circleRadius + x - smallCircleRadius,
          top: circleRadius + y - smallCircleRadius,
          child: Container(
            width: smallCircleRadius * 2,
            height: smallCircleRadius * 2,
            decoration: BoxDecoration(
              color: smallCircleColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: circleRadius * 2,
          height: circleRadius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: circleColor,
              width: 2.0,
            ),
          ),
        ),
        ...smallCircles,
      ],
    );
  }
}
