import 'package:flutter/cupertino.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/screens/news/comments_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';

class UiHelper {
  static showCommentsSheet(BuildContext context, int newId) {
    context.showBottomSheet(
      context,
      builder: (context) {
        return CommentsScreen(newId: newId);
      },
    );
  }

  static navigateToLeagueInfo(
    BuildContext context, {
    required LeagueData leagueData,
    int? teamId,
    bool isNews = false,
  }) {
    leagueData.subType == LeagueTypeEnum.cubInternational
        ? context.push(
            ChampionsLeagueScreen(
              leagueId: leagueData.id!,
              teamId: teamId,
            ),
          )
        : context.push(
            LeagueInfoScreen(
              leagueId: leagueData.id!,
              subType: leagueData.subType!,
              initialIndex: isNews
                  ? leagueData.subType == LeagueTypeEnum.domestic
                      ? 3
                      : 2
                  : 0,
            ),
          );
  }
}
