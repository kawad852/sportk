import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class LiveSwitch extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;
  final Function(bool) onChanged;

  const LiveSwitch({
    super.key,
    required this.active,
    required this.onTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: AnimatedToggleSwitch<bool>.rolling(
        current: active,
        values: const [true, false],
        onChanged: onChanged,
        height: 30,
        borderWidth: 0,
        style: ToggleStyle(
          backgroundColor: context.colorPalette.greyD9D,
          borderRadius: BorderRadius.circular(100),
        ),
        textDirection: context.isLTR ? TextDirection.rtl : TextDirection.ltr,
        indicatorAppearingBuilder: (context, value, _) {
          return GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              height: 25,
              width: 35,
              duration: const Duration(milliseconds: 700),
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? context.colorPalette.red000 : context.colorPalette.blue9FE,
                borderRadius: BorderRadius.circular(100),
              ),
              child: FittedBox(
                child: Text(
                  context.appLocalization.live,
                  style: context.textTheme.labelSmall!.copyWith(
                    color: active ? context.colorScheme.surface : context.colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
