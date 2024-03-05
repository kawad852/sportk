import 'package:flutter/material.dart';
import 'dart:math';

class MatchTimerCircle extends StatefulWidget {
  final double currentTime;
  final List<double> goalsTime;

  const MatchTimerCircle({
   super.key,
    required this.currentTime,
    required this.goalsTime,
  });

  @override
  State<MatchTimerCircle> createState() => _MatchTimerCircleState();
}

class _MatchTimerCircleState extends State<MatchTimerCircle> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: MatchTimerPainter(
        currentTime: widget.currentTime,
        goalsTime: widget.goalsTime,
      ),
    );
  }
}

class MatchTimerPainter extends CustomPainter {
  final double currentTime;
  final List<double> goalsTime;

  MatchTimerPainter({
    required this.currentTime,
    required this.goalsTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCirclePaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      outerCirclePaint,
    );

    Paint progressCirclePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    double progressAngle = (2 * pi * (currentTime / 90));

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      -pi / 2,
      progressAngle,
      false,
      progressCirclePaint,
    );

    Paint goalCirclePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var goalTime in goalsTime) {
      double goalAngle = (2 * pi * (goalTime / 90));
      double goalX = size.width / 2 + (size.width / 2 * cos(-pi / 2 + goalAngle));
      double goalY = size.height / 2 + (size.width / 2 * sin(-pi / 2 + goalAngle));

      canvas.drawCircle(
        Offset(goalX, goalY),
        5,
        goalCirclePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
