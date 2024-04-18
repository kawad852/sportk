import 'package:flutter/material.dart';
import 'package:sportk/main.dart';
import 'package:sportk/screens/match_info/match_info_screen.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/screens/web/web_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/shared_pref.dart';

class NotificationsRouteService {
  void toggle(BuildContext context, Map<String, dynamic> data) {
    try {
      final id = data['id'] as String?;
      final type = data['type'] as String?;
      MySharedPreferences.showAd = false;
      switch (type) {
        case NotificationsType.blog:
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => NewsDetailsScreen(newId: int.parse(id!)),
            ),
          );
          break;
        case NotificationsType.url:
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => WebScreen(url: data['url']),
            ),
          );
          break;
        case NotificationsType.match:
        case NotificationsType.live:
          context.push(
            MatchInfoScreen(
              matchId: int.parse(data['id']),
              leagueId: int.parse(data['league_id']),
              subType: data['sub_type'],
            ),
          );
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint("RouteError:: $e");
    }
  }
}
