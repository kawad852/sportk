import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueBuilder extends StatefulWidget {
  final int leagueId;
  final Widget Function(BuildContext context, LeagueModel snapshot) builder;

  const LeagueBuilder({
    super.key,
    required this.leagueId,
    required this.builder,
  });

  @override
  State<LeagueBuilder> createState() => _LeagueBuilderState();
}

class _LeagueBuilderState extends State<LeagueBuilder> with AutomaticKeepAliveClientMixin {
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
    super.build(context);
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
        final league = snapshot.data;
        if (league?.data == null) {
          return const SizedBox.shrink();
        }
        return widget.builder(context, league!);
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
