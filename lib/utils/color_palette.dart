import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';

class ColorPalette {
  final BuildContext _context;

  ColorPalette(this._context);

  static of(BuildContext context) => ColorPalette(context);

  bool get _isLightTheme => MyTheme.isLightTheme(_context);

  // TODO: Mihyar: consider the dark Theme
  ///grey
  Color get grey2F2 => _isLightTheme ? const Color(0xFFF2F2F2) : const Color(0xFF151925);
  Color get grey3F3 => _isLightTheme ? const Color(0xFFF3F3F3) : const Color(0xFF151925);
  Color get grey9E9 => _isLightTheme ? const Color(0xFFE9E9E9) : const Color(0xFF1A1D2E);
  Color get greyD9D => _isLightTheme ? const Color(0xFFD9D9D9) : const Color(0xFF272A3A);
  Color get grey3F1 => const Color(0xFFF3F3F1);//not used (team bubble)
  Color get greyAF8 => _isLightTheme ? const Color(0xFFFAFAF8) : const Color(0xFF5C7B92);
  Color get grey0F5 => _isLightTheme ? const Color(0xFFF1F0F5) : const Color(0xFF1C202C);
  Color get greyAAA => const Color(0xFFAAAAAA);//line color  same
  Color get grey9F9 => _isLightTheme ? const Color(0xFFF9F9F9) : const Color(0xFF151925);

  ///blue
  Color get blueD4B => _isLightTheme ? const Color(0xFF032D4B) : Colors.white;
  Color get blue1FC => const Color(0xFFE2F1FC); //not used
  Color get blue1AD4B => const Color(0x1A032D4B);//same
  Color get blueABB => _isLightTheme ? const Color(0xFFABB8C1) : const Color(0xFF515464);
  Color get blueE2F =>_isLightTheme ? const Color(0x66E2F1FC):const Color(0xFF151925);
  Color get blue1F8 => const Color(0xFF1F85CD);//same dark and light
  Color get blue19A => const Color(0xFF5E819A);// color feed_back
  Color get blue9FE => const Color(0xFFF3F9FE);// live switch
  Color get blueF9F =>_isLightTheme ? const Color(0xFFF9F9F9):const Color(0xFF151925);
  Color get blue8E3 => const Color(0xFFC8D8E3); //not used
  Color get blue4F0 => _isLightTheme ? const Color(0xFFE2E4F0) : const Color(0xFF202538);
  Color get icon => _isLightTheme ? const Color(0xFF032D4B) : const Color(0xFFC5C8D7);
  Color get homeMatchBubble => _isLightTheme ? white : const Color(0xFF151925);

  ///red
  Color get red000 => const Color(0xFFCC0000);//same
  Color get red100 => const Color(0xFFFF0100);//nav bar 

  ///text
  Color get text444 => const Color(0xFF444444);//not used
  Color get text666 => const Color(0xFF666666);//not used
  Color get text97 => const Color(0xFF979797);//same

  ///common
  Color get white => Colors.white;
  Color get black => Colors.black;

  //yellow
  Color get yellowF7A => const Color(0xFFF7AA05);
  Color get yellowF7A20 => const Color(0x33F7AA05);
  Color get yellowFCC => const Color(0xFFFCC200);//not used (match info)

  //green
  Color get greenAD0 => const Color(0xFF00AD05);//not used (match info)
  Color get green057 => const Color(0xFF057008);//sooooon

  Color get scaffoldColor => _isLightTheme ? white : const Color(0xFF0D1019);

  //label
  Color get tabColor => _isLightTheme ? const Color(0xFF032D4B) : const Color(0xFFCC0000);
}
