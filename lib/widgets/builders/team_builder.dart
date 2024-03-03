import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class TeamBuilder extends StatefulWidget {
  final int teamId;
  final Widget Function(BuildContext context, TeamInfoData snapshot) builder;

  const TeamBuilder({
    super.key,
    required this.teamId,
    required this.builder,
  });

  @override
  State<TeamBuilder> createState() => _TeamBuilderState();
}

class _TeamBuilderState extends State<TeamBuilder> with AutomaticKeepAliveClientMixin {
  late Future<TeamInfoModel> _teamFuture;
  late FootBallProvider _footBallProvider;

  void _fetchLeagueByDate() {
    _teamFuture = _footBallProvider.fetchTeamInfo(teamId: widget.teamId);
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
      future: _teamFuture,
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
        final league = snapshot.data!.data!;
        return widget.builder(context, league);
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
