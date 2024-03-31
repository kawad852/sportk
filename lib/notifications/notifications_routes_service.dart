import 'package:flutter/material.dart';
import 'package:sportk/main.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/screens/web/web_screen.dart';
import 'package:sportk/utils/enums.dart';

class NotificationsRouteService {
  void toggle(BuildContext context, Map<String, dynamic> data) {
    try {
      final id = data['id'] as int?;
      final type = data['type'] as String?;
      switch (type) {
        case NotificationsType.blog:
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) => NewsDetailsScreen(newId: id!),
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

          /// handle route here
          // navigatorKey.currentState!.push(
          //   MaterialPageRoute(
          //     builder: (context) =>  MatchInfoScreen(matchId: ),
          //   ),
          // );
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint("RouteError:: $e");
    }
  }
}
