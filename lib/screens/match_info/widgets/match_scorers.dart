import 'package:flutter/material.dart';
import 'package:sportk/screens/match_info/widgets/assister_scorers.dart';
import 'package:sportk/screens/match_info/widgets/match_live.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/league_scorers/league_scorers.dart';

class MatchScorers extends StatefulWidget {
  final int matchId;
  final int leagueId;
  const MatchScorers({super.key, required this.leagueId, required this.matchId});

  @override
  State<MatchScorers> createState() => _MatchScorersState();
}

class _MatchScorersState extends State<MatchScorers> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MatchLive(matchId: widget.matchId),
        Container(
          height: 45,
          width: double.infinity,
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            color: context.colorPalette.grey9E9,
          ),
          child: TabBar(
            controller: _controller,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: context.colorPalette.white,
            unselectedLabelColor: context.colorPalette.blueD4B,
            labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
            indicator: BoxDecoration(
              color: context.colorPalette.tabColor,
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            ),
            tabs: [
              Center(child: Text(context.appLocalization.scorers)),
              Center(child: Text(context.appLocalization.assisters)),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              LeagueScorers(leagueId: widget.leagueId),
              AssistersScorers(leagueId: widget.leagueId),
            ],
          ),
        ),
      ],
    );
  }
}
