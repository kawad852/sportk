import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';

class ColorPalette {
  final BuildContext _context;

  ColorPalette(this._context);

  static of(BuildContext context) => ColorPalette(context);

  bool get _isLightTheme => MyTheme.isLightTheme(_context);

  ///grey
  Color get grey2F2 => _isLightTheme ? const Color(0xFFF2F2F2) : const Color(0xFFF2F2F2);
  Color get grey3F3 => const Color(0xFFF3F3F3);
  Color get grey9E9 => const Color(0xFFE9E9E9);
  Color get greyD9D => const Color(0xFFD9D9D9);
  Color get grey3F1 => const Color(0xFFF3F3F1);
  Color get greyEAE => const Color(0xFFEAEAEA);
  Color get greyAAA => const Color(0xFFAAAAAA);




  ///blue
  Color get blueD4B => const Color(0xFF032D4B);
  Color get blue1FC => const Color(0xFFE2F1FC);
  Color get blue1AD4B => const Color(0x1A032D4B);
  Color get blueABB => const Color(0xFFABB8C1);
  Color get blueE2F => const Color(0x66E2F1FC);


  ///red
  Color get red000 => const Color(0xFFCC0000);

  ///text
  Color get text444 => const Color(0xFF444444);
  Color get text666 => const Color(0xFF666666);
  Color get text97 => const Color(0xFF979797);

  ///common
  Color get white => Colors.white;
  Color get black => Colors.black;

  //yellow
  Color get yellowF7A => const Color(0xFFF7AA05);
  Color get yellowFCC => const Color(0xFFFCC200);

  //green
  Color get greenAD0 => const Color(0xFF00AD05);
  Color get green057 => const Color(0xFF057008);

}
