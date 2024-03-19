import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
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
        backgroundColor: context.colorPalette.walletButton,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomSvg(
                icon,
                color: context.colorPalette.walletIcon,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 13, color: context.colorPalette.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
