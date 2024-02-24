import 'package:flutter/material.dart';
import 'package:sportk/utils/my_theme.dart';

class LoadingBubble extends StatelessWidget {
  final double? width;
  final double radius;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const LoadingBubble({
    super.key,
    this.width,
    this.radius = MyTheme.radiusSecondary,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
