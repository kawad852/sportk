import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key, this.color, this.fontWeight});
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final colorS = context.colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          context.pop();
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_back_ios,
              color: color ?? colorS,
            ),
            Text(
              context.appLocalization.back,
              style: TextStyle(
                fontWeight: fontWeight ?? FontWeight.w600,
                color: color ?? colorS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
