import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/champions_league_screen.dart';
import 'package:sportk/screens/league_info/league_info_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/league_tile.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueBuilder extends StatefulWidget {
  final int leagueId;

  const LeagueBuilder({
    super.key,
    required this.leagueId,
  });

  @override
  State<LeagueBuilder> createState() => _LeagueBuilderState();
}

class _LeagueBuilderState extends State<LeagueBuilder> {
  late Future<LeagueModel> _leagueFuture;
  late FootBallProvider _footBallProvider;

  void _fetchLeagueByDate() {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: widget.leagueId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _fetchLeagueByDate();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _leagueFuture,
      onRetry: () {
        setState(() {
          _fetchLeagueByDate();
        });
      },
      onLoading: () {
        return const ShimmerLoading(
          child: LoadingBubble(
            height: 50,
          ),
        );
      },
      onComplete: (context, snapshot) {
        final league = snapshot.data!;
        return LeagueTile(
          league: league.data!,
          onTap: () {
            if (league.data!.subType == LeagueTypeEnum.cubInternational) {
              context.push(
                ChampionsLeagueScreen(leagueId: widget.leagueId),
              );
            } else {
              context.push(
                LeagueInfoScreen(leagueId: widget.leagueId, subType: league.data!.subType!),
              );
            }
          },
        );
      },
    );
  }
}
