import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: context.colorPalette.greyAAA,
      thickness: 2,
      indent: 20,
      endIndent: 65,
    );
  }
}
