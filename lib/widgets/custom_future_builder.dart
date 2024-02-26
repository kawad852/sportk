import 'package:flutter/material.dart';
import 'package:sportk/alerts/errors/app_error_widget.dart';
import 'package:sportk/widgets/custom_loading_indicator.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final VoidCallback onRetry;
  final Function(BuildContext context, AsyncSnapshot<T?> snapshot) onComplete;
  final Function()? onLoading;
  final Function(AsyncSnapshot<T?> snapshot)? onError;
  final bool withBackgroundColor;

  const CustomFutureBuilder({
    Key? key,
    required this.future,
    required this.onRetry,
    required this.onComplete,
    this.onLoading,
    this.onError,
    this.withBackgroundColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: future,
      builder: (context, AsyncSnapshot<T?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return onLoading == null ? CustomLoadingIndicator(withBackgroundColor: withBackgroundColor) : onLoading!();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return onComplete(context, snapshot);
            } else {
              return onError == null
                  ? AppErrorWidget(
                      error: snapshot.error,
                      onRetry: onRetry,
                    )
                  : onError!(snapshot);
            }
        }
      },
    );
  }
}
