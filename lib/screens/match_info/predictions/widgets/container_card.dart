import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';

class ContainerCard extends StatelessWidget {
  final double height;
  final Widget child;
  const ContainerCard({super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        width: double.infinity,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorPalette.grey3F3,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: child,
      ),
    );
  }
}
