import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class PredictionText extends StatelessWidget {
  final String text;
  final int flex;
  final TextAlign? textAlign;
  const PredictionText({super.key, required this.text, this.flex = 1, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: context.colorPalette.white,
        ),
      ),
    );
  }
}
