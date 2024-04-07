import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueTile extends StatelessWidget {
  final LeagueData league;
  final Widget? trailing;
  final VoidCallback onTap;

  const LeagueTile({
    super.key,
    required this.league,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyTheme.radiusPrimary),
        color: context.colorPalette.blue4F0,
        boxShadow: UiHelper.getShadow(context),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        // tileColor: context.colorPalette.blue4F0,
        leading: CustomNetworkImage(
          league.logo ?? league.imagePath!,
          shape: BoxShape.circle,
          width: 25,
          height: 25,
        ),
        title: Text(
          league.name!.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
