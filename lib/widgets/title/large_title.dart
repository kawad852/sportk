import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class LargeTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;

  const LargeTitle(
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
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
