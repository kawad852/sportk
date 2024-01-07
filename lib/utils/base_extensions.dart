import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sportk/alerts/loading/app_loading_indicators.dart';
import 'package:sportk/providers/app_provider.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/utils/app_routes.dart';
import 'package:sportk/utils/color_palette.dart';
import 'package:sportk/utils/enums.dart';

extension LanguageExtension on BuildContext {
  AppLocalizations get appLocalization => AppLocalizations.of(this)!;

  String get languageCode => Localizations.localeOf(this).languageCode;

  bool get isLTR => Localizations.localeOf(this).languageCode == LanguageEnum.english;

  String translate({
    required String textEN,
    required String textAR,
  }) {
    return isLTR ? textEN : textAR;
  }
}

extension MediaQueryExtension on BuildContext {
  Size get mediaQuery => MediaQuery.sizeOf(this);
}

extension NavigatorExtension on BuildContext {
  Future<dynamic> push(Widget screen) async {
    final routeName = AppRoutes.names[screen.runtimeType];
    final value = await Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
        settings: RouteSettings(name: routeName),
      ),
    );
    return value;
  }

  void pushReplacement(
    Widget screen, {
    Function(dynamic value)? then,
  }) async {
    final routeName = AppRoutes.names[screen.runtimeType];
    final value = await Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
        settings: RouteSettings(name: routeName),
      ),
    );
    if (then != null) {
      then(value);
    }
  }

  void pushAndRemoveUntil(Widget screen) {
    final routeName = AppRoutes.names[screen.runtimeType];
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
        settings: RouteSettings(name: routeName),
      ),
      (route) => false,
    );
  }

  void pop([value]) => Navigator.pop(this, value);
}

extension AppLoadingIncidatorExtension on BuildContext {
  AppLoadingIndicator get loaders => AppLoadingIndicator.of(this);
}

extension ThemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ColorPalette get colorPalette => ColorPalette.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ProvidersExtension on BuildContext {
  AuthProvider get authProvider => read<AuthProvider>();
  AppProvider get appProvider => read<AppProvider>();
}

extension CommonExtensions on BuildContext {
  void unFocusKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
  double get systemButtonHeight => Theme.of(this).buttonTheme.height;
}
