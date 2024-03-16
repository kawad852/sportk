import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class NewsChampCard extends StatelessWidget {
  final LeagueData league;

  const NewsChampCard({
    super.key,
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          LeagueInfoScreen(
            leagueId: league.id!,
            subType: league.subType!,
            initialIndex: 4,
          ),
        );
      },
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: context.colorPalette.grey9E9,
          borderRadius: BorderRadius.circular(MyTheme.radiusPrimary),
        ),
        alignment: Alignment.center,
        child: CustomNetworkImage(
          league.logo!,
          radius: 0,
          width: 48,
          height: 30,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
