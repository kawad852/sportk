import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final String text;
  const TableText({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
