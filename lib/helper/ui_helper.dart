import 'package:flutter/cupertino.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/screens/news/comments_screen.dart';

class UiHelper {
  static showCommentsSheet(BuildContext context, int newId) {
    context.showBottomSheet(
      context,
      builder: (context) {
        return CommentsScreen(newId: newId);
      },
    );
  }
}
