import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportk/utils/my_images.dart';

class MatchTimerCircle extends StatefulWidget {
  final double currentTime;
  final List<double> goalsTime;
  final int? timeAdded;
  final bool isHalfTime;
  final double width;
  final double height;
  final Color? minuteColor;
  final double? fontsize;

  const MatchTimerCircle({
    super.key,
    required this.currentTime,
    required this.goalsTime,
    required this.timeAdded,
    this.isHalfTime = false,
    this.width = 40,
    this.height = 50,
    this.minuteColor,
    this.fontsize,
  });

  static late ui.Image ballImage;

  static Future loadBallImage() async {
    final data = await rootBundle.load(MyImages.goalsEvent);
    final image = await decodeImageFromList(data.buffer.asUint8List());
    ballImage = image;
  }

  @override
  State<MatchTimerCircle> createState() => _MatchTimerCircleState();
}

class _MatchTimerCircleState extends State<MatchTimerCircle> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: MatchTimerPainter(
        currentTime: widget.currentTime,
        goalsTime: widget.goalsTime,
        timeAdded: widget.timeAdded,
        isHalfTime: widget.isHalfTime,
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Text(
            "${widget.currentTime.round().toInt().toString()}'",
            style: TextStyle(
              color: widget.minuteColor,
              fontSize: widget.fontsize,
            ),
          ),
        ),
      ),
    );
  }
}

class MatchTimerPainter extends CustomPainter {
  final double currentTime;
  final List<double> goalsTime;
  final int? timeAdded;
  final bool isHalfTime;

  MatchTimerPainter({
    required this.isHalfTime,
    required this.currentTime,
    required this.goalsTime,
    required this.timeAdded,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //main circle
    Paint outerCirclePaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      outerCirclePaint,
    );
    //topLine
    Paint lineTopPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Offset startPoint = Offset(size.width / 2, 0);
    Offset endPoint = Offset(size.width / 2, size.height / 2 - size.width / 2);

    canvas.drawLine(startPoint, endPoint, lineTopPaint);

    //bottom line
    Paint lineBottomPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Offset start = Offset(size.width / 2, size.height / 2 + size.width / 2);
    Offset end = Offset(size.width / 2, size.height);

    canvas.drawLine(start, end, lineBottomPaint);

    //progress time
    Paint progressCirclePaint = Paint()
      ..color = isHalfTime ? Colors.orange : Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double progressAngle = timeAdded == null
        ? (2 * pi * (currentTime / 90))
        : (2 * pi * (currentTime / (90 + timeAdded!)));

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      -pi / 2,
      progressAngle,
      false,
      progressCirclePaint,
    );

    //goals
    for (var goalTime in goalsTime) {
      double goalAngle = timeAdded == null
          ? (2 * pi * (goalTime / 90))
          : (2 * pi * (goalTime / (90 + timeAdded!)));
      double goalX = size.width / 2 + (size.width / 2 * cos(-pi / 2 + goalAngle));
      double goalY = size.height / 2 + (size.width / 2 * sin(-pi / 2 + goalAngle));

      canvas.drawImage(
        MatchTimerCircle.ballImage,
        Offset(goalX - 5, goalY - 5),
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
