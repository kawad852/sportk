import 'package:flutter/material.dart';

class NotificationsRouteService {
  static const String viewStory = 'viewStory';
  static const String subscription = 'subscription';

  void toggle(BuildContext context) {
    try {
      // if (MySharedPreferences.userId == 0) return;
      // switch (notificationDataModel.type) {
      //   case viewStory:
      //     Navigator.of(context, rootNavigator: true).push(
      //       MaterialPageRoute(
      //         builder: (context) => LoadStoryScreen(
      //           documentId: notificationDataModel.uid!,
      //         ),
      //       ),
      //     );
      //     break;
      //   case subscription:
      //     navigatorKey.currentState!.push(
      //       MaterialPageRoute(
      //         builder: (context) => const SubscriptionsScreen(),
      //       ),
      //     );
      //     break;
      //   default:
      //     break;
      // }
    } catch (e) {
      debugPrint("RouteError:: $e");
    }
  }
}
