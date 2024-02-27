import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class VexLoader extends StatelessWidget {
  const VexLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: context.loaders.circular(isSmall: true),
    );
  }
}
