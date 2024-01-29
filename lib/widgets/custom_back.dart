import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: color ?? context.colorPalette.black,
            )),
        Text(
          context.appLocalization.back,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color ?? context.colorPalette.black,
          ),
        )
      ],
    );
  }
}
