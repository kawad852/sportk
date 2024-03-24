import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class RoundedContainer extends StatelessWidget {
  final Color color;
  final String text;
  const RoundedContainer({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsetsDirectional.only(end: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: context.colorPalette.white),
      ),
    );
  }
}
