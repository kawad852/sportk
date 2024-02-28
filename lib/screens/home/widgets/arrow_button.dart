import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class ArrowButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData iconData;

  const ArrowButton({
    super.key,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              size: 20,
              color: onTap != null ? null : context.colorScheme.outlineVariant,
            ),
          ),
        ),
      ),
    );
  }
}
