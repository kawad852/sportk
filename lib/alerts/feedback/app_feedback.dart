import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sportk/utils/base_extensions.dart';

extension AppFeedbacks on BuildContext {
  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  void showSnackBar(
    String msg, {
    bool floating = true,
    int duration = 4,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        duration: Duration(seconds: duration),
      ),
    );
  }

  Future<T?> showDialog<T>({
    String? titleText,
    String? confirmTitle,
    Widget? titleWidget,
    String? bodyText,
    Widget? bodyWidget,
    List<Widget>? actions,
    double? maxWidth,
    Color? confirmButtonBackgroundColor,
    Color? cancelButtonForegroundColor,
    bool warning = false,
  }) async {
    return showGeneralDialog<T?>(
      barrierDismissible: true,
      barrierLabel: '',
      context: this,
      transitionBuilder: (context, a1, a2, widget) {
        return Opacity(
          opacity: a1.value,
          child: AlertDialog(
            title: titleWidget ?? Text(titleText!),
            content: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth ?? 400),
              child: bodyWidget ?? Text(bodyText!),
            ),
            actions: actions ??
                [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: cancelButtonForegroundColor ?? (warning ? context.colorScheme.onSurface : null),
                    ),
                    child: Text(context.appLocalization.cancel),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: confirmButtonBackgroundColor ?? (warning ? context.colorScheme.error : null),
                    ),
                    onPressed: () {
                      context.pop(true);
                    },
                    child: Text(context.appLocalization.confirm),
                  ),
                ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (BuildContext context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    ).then<T?>((value) => value);
  }
}
