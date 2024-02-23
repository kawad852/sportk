import 'package:flutter/material.dart';

class LeagueScorersCell extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  const LeagueScorersCell({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
