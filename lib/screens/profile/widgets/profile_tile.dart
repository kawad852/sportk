import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_svg.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final Widget trailing;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: context.colorPalette.grey9F9,
      leading: CustomSvg(icon),
      title: Text(title),
      trailing: trailing,
    );
  }
}
