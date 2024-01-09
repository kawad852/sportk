import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueTile extends StatelessWidget {
  final Widget? trailing;

  const LeagueTile({
    super.key,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // context.push(const LeagueScreen());
      },
      dense: true,
      tileColor: context.colorPalette.grey2F2,
      leading: const CustomNetworkImage(
        kFakeImage,
        radius: 0,
        width: 25,
        height: 25,
      ),
      title: const Text(
        "English League",
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
    );
  }
}
