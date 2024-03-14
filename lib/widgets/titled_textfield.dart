import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class TitledTextField extends StatelessWidget {
  final String title;
  final Widget child;
  final bool required;

  const TitledTextField({
    Key? key,
    required this.title,
    required this.child,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '* $title',
          style: context.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        child,
        const SizedBox(height: 13),
      ],
    );
  }
}
