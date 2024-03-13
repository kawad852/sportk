import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportk/utils/base_extensions.dart';

const kEditorBottomPadding = 16.0;
const kProductBubbleHeight = 70.0;
const kBarLeadingWith = 80.0;
const kBarCollapsedHeight = 250.0;

class MyTheme {
  static const Color primaryLightColor = Color(0xFF1A73E8);
  static const Color secondaryLightColor = Color(0xFFFFCA28);
  static const Color tertiaryLightColor = Color(0xFF1B3A57);

  static final String fontFamily = GoogleFonts.cairo().fontFamily!;

  static const double radiusPrimary = 5;
  static const double radiusSecondary = 10;
  static const double radiusTertiary = 16;

  static bool isLightTheme(BuildContext context) => context.colorScheme.brightness == Brightness.light;

  static InputDecorationTheme inputDecorationTheme(BuildContext context, ColorScheme colorScheme) => InputDecorationTheme(
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 10),
        fillColor: context.colorPalette.blueD4B.withOpacity(0.10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPrimary),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPrimary),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPrimary),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPrimary),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPrimary),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      );

  ThemeData materialTheme(BuildContext context, ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: context.colorPalette.white,
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
          borderRadius: BorderRadius.circular(radiusPrimary),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPrimary),
          ),
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: inputDecorationTheme(context, colorScheme),
    );
  }
}
