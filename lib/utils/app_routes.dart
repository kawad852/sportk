import 'package:flutter/cupertino.dart';
import 'package:sportk/screens/base/app_nav_bar.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/screens/registration/registration_screen.dart';

class AppRoutes {
  static const String defaultRouteName = Navigator.defaultRouteName;

  static const String appNavBar = '/app-nav-bar';
  static const String login = '/login';
  static const String newDetails = '/new-details';

  static Map<dynamic, String> names = {
    AppNavBar: appNavBar,
    RegistrationScreen: login,
    NewsDetailsScreen: newDetails,
  };
}
