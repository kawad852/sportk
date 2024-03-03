import 'package:flutter/material.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

class WalletButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String icon;
  const WalletButton({super.key, required this.onPressed, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StretchedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomSvg(icon),
              Text(
                text,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
