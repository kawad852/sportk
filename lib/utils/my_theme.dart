import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportk/utils/base_extensions.dart';

const kEditorBottomPadding = 16.0;
const kProductBubbleHeight = 70.0;

class MyTheme {
  static const Color primaryLightColor = Color(0xFF1A73E8);
  static const Color secondaryLightColor = Color(0xFFFFCA28);
  static const Color tertiaryLightColor = Color(0xFF1B3A57);

  static final String fontFamily = GoogleFonts.cairo().fontFamily!;

  static const double radiusPrimary = 20;
  static const double radiusSecondary = 16;
  static const double radiusTertiary = 10;

  static bool isLightTheme(BuildContext context) => context.colorScheme.brightness == Brightness.light;

  ThemeData materialTheme(BuildContext context, ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      expansionTileTheme: ExpansionTileThemeData(
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(radiusSecondary),
          ),
        ),
        collapsedBackgroundColor: colorScheme.secondaryContainer,
        backgroundColor: colorScheme.secondaryContainer,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSecondary),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusTertiary),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusTertiary),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusTertiary),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusTertiary),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusTertiary),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
    );
  }
}
