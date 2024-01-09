import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';

class ColorPalette {
  final BuildContext _context;

  ColorPalette(this._context);

  static of(BuildContext context) => ColorPalette(context);

  bool get _isLightTheme => MyTheme.isLightTheme(_context);

  ///grey
  Color get grey2F2 => const Color(0xFFF2F2F2);

  ///blue
  Color get blueD4B => const Color(0xFF032D4B);
  Color get blue1FC => const Color(0xFFE2F1FC);

  ///red
  Color get red000 => const Color(0xFFCC0000);

  ///text
  Color get text444 => const Color(0xFF444444);
  Color get text666 => const Color(0xFF666666);

  ///common
  Color get white => Colors.white;
  Color get black => Colors.black;
}
