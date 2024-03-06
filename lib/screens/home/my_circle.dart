import 'dart:math';

import 'package:flutter/material.dart';

enum StartSide {
  left,
  right,
}

class ClockCircles extends StatelessWidget {
  final double circleRadius;
  final int numberOfCircles;
  final double circleSpacing;
  final Color circleColor;
  final double smallCircleRadius;
  final Color smallCircleColor;
  final StartSide startSide;

  const ClockCircles({
    Key? key,
    required this.circleRadius,
    required this.numberOfCircles,
    required this.circleSpacing,
    required this.circleColor,
    required this.smallCircleRadius,
    required this.smallCircleColor,
    required this.startSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> smallCircles = [];
    final double angle = pi / numberOfCircles;
    double startAngle;
    double endAngle;
    if (startSide == StartSide.left) {
      startAngle = -pi / 2.5;
      endAngle = 0;
    } else {
      startAngle = 0;
      endAngle = pi / 2.5;
    }

    for (int i = 0; i < numberOfCircles; i++) {
      final double hourAngle =
          startAngle + i * (endAngle - startAngle) / (numberOfCircles - (numberOfCircles / 2));
      final double x = circleRadius * cos(hourAngle);
      final double y = circleRadius * sin(hourAngle);
      final circleSize = smallCircleRadius * 2;
      smallCircles.add(
        Positioned(
          left: circleRadius + x - smallCircleRadius,
          top: circleRadius + y - smallCircleRadius,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              color: smallCircleColor,
              shape: BoxShape.circle,
            ),
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
