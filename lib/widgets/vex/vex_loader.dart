import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class VexLoader extends StatelessWidget {
  final double topSpace;
  final double bottomSpace;
  const VexLoader({
    super.key,
    this.topSpace = 40,
    this.bottomSpace = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topSpace, bottom: bottomSpace),
      child: context.loaders.circular(isSmall: true),
    );
  }
}
