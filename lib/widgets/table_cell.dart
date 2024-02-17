import 'package:flutter/material.dart';

class TableCell extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  const TableCell({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(""),
    );
  }
}
