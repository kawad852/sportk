import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class ContainerCard extends StatelessWidget {
  final double height;
  final Widget child;
  const ContainerCard({super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
