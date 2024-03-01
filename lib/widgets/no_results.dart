import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class NoResults extends StatelessWidget {
  final String? title, body;
  final Widget? header, footer;

  const NoResults({
    super.key,
    this.title,
    this.body,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (header != null) header!,
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title!,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (body != null)
            Text(
              body!,
              textAlign: TextAlign.center,
            ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
