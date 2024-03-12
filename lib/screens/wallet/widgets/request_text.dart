import 'package:flutter/material.dart';

class RequsetText extends StatelessWidget {
  final String text;
  final Color? textColor;
  const RequsetText({super.key, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }
}
