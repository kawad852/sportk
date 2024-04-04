import 'package:flutter/material.dart';
import 'package:sportk/main.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/screens/match_info/match_info_screen.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/screens/web/web_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';

class NotificationsRouteService {
  void toggle(BuildContext context, Map<String, dynamic> data) {
    try {
      final id = data['id'] as String?;
      final type = data['type'] as String?;
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
          ApiFutureBuilder<MatchPointsModel>().fetch(
            context,
            future: () async {
              final matchPoints = context.commonProvider.getMatchPoints(int.parse(data['id']));
              return matchPoints;
            },
            onComplete: (snapshot) async {
              await context.push(
                MatchInfoScreen(
                  matchId: int.parse(data['id']),
                  leagueId: int.parse(data['league_id']),
                  subType: data['sub_type'],
                  pointsData: snapshot.data!,
                  showPredict: snapshot.data!.status == 1,
                ),
              );
            },
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
