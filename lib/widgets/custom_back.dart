import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key, this.color, this.fontWeight});
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            color: color ?? context.colorPalette.black,
          ),
          Text(
            context.appLocalization.back,
            style: TextStyle(
              fontWeight: fontWeight ?? FontWeight.w600,
              color: color ?? context.colorPalette.black,
            ),
          ),
        ],
      ),
    );
  }
}
