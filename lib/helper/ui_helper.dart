import 'package:flutter/cupertino.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/screens/match_info/match_info_screen.dart';
import 'package:sportk/screens/news/comments_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';

class UiHelper {
  static Future<dynamic> showCommentsSheet(
    BuildContext context,
    int newId, {
    int? commentId,
  }) async {
    return context.showBottomSheet(
      context,
      builder: (context) {
        return CommentsScreen(
          newId: newId,
          commentId: commentId,
        );
      },
    ).then((value) {
      return value;
    });
  }

  static navigateToLeagueInfo(
    BuildContext context, {
    required LeagueData leagueData,
    Function? afterNavigate,
    int? teamId,
    bool isNews = false,
  }) async {
    leagueData.subType == LeagueTypeEnum.cubInternational
        ? {
            await context.push(
              ChampionsLeagueScreen(
                leagueId: leagueData.id!,
                teamId: teamId,
                initialIndex: isNews ? 3 : 0,
              ),
            ),
            if (afterNavigate != null) afterNavigate()
          }
        : {
            await context.push(
              LeagueInfoScreen(
                leagueId: leagueData.id!,
                subType: leagueData.subType!,
                initialIndex: isNews
                    ? leagueData.subType != LeagueTypeEnum.domestic
                        ? 2
                        : 3
                    : 0,
              ),
            ),
            if (afterNavigate != null) afterNavigate()
          };
  }

  static String getMatchState(BuildContext context, {required int stateId}) {
    switch (stateId) {
      case 1:
        return context.appLocalization.notStarted;
      case 2:
        return context.appLocalization.half1;
      case 3:
        return context.appLocalization.halfTime;
      case 4:
      case 25:
        return context.appLocalization.waitingPenalties;
      case 5:
        return context.appLocalization.fullTime;
      case 6:
        return context.appLocalization.extraTime;
      case 7:
        return context.appLocalization.finishedAfterExtraTime;
      case 8:
        return context.appLocalization.fullAfterPenalties;
      case 9:
        return context.appLocalization.penaltyShootout;
      case 10:
        return context.appLocalization.postPoned;
      case 11:
        return context.appLocalization.suspended;
      case 12:
        return context.appLocalization.cancelled;
      case 13:
        return context.appLocalization.toAnnounced;
      case 14:
        return context.appLocalization.walkOver;
      case 15:
        return context.appLocalization.abandoned;
      case 16:
        return context.appLocalization.delayed;
      case 17:
        return context.appLocalization.awarded;
      case 18:
        return context.appLocalization.interrupted;
      case 19:
        return context.appLocalization.awaitingState;
      case 20:
        return context.appLocalization.deleted;
      case 21:
        return context.appLocalization.extraTimeBreak;
      case 22:
        return context.appLocalization.half2;
      case 26:
        return context.appLocalization.pending;
      default:
        return context.appLocalization.pending;
    }
  }

  static navigateToMatchInfo(
    BuildContext context, {
    required int matchId,
    required int leagueId,
    required String subType,
    required Function afterNavigate,
  }) async {
    await context.push(
      MatchInfoScreen(
        matchId: matchId,
        leagueId: leagueId,
        subType: subType,
      ),
    );
    afterNavigate();
  }

  static List<BoxShadow> getShadow(BuildContext context) {
    return [
      BoxShadow(
        color: context.colorScheme.inverseSurface
            .withOpacity(0.3), // Semi-transparent gray shadow
        blurRadius: 1,
        spreadRadius: 0.2,
        offset:
            const Offset(0.5, 0.5), // Shadow slightly shifted down and right
      )
    ];
  }
}
