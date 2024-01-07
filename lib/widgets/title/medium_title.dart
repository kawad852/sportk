import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class MediumTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;

  const MediumTitle(
    this.title, {
    super.key,
    this.padding,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        title,
        style: context.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
    );
  }
}
