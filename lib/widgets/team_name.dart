import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class TeamName extends StatefulWidget {
  final int? teamId;
  const TeamName({super.key, required this.teamId});

  @override
  State<TeamName> createState() => _TeamNameState();
}

class _TeamNameState extends State<TeamName> {
  late FootBallProvider _footBallProvider;
  late Future<TeamInfoModel> _teamFuture;
  void _initializeFuture() {
    _teamFuture = _footBallProvider.fetchTeamInfo(teamId: widget.teamId!);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    widget.teamId == null ? null : _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return widget.teamId == null
        ? const SizedBox.shrink()
        : CustomFutureBuilder(
            future: _teamFuture,
            onRetry: () {
              setState(() {
                _initializeFuture();
              });
            },
            onLoading: () {
              return const ShimmerLoading(
                child: LoadingBubble(
                  width: 40,
                  height: 9,
                  radius: 0,
                ),
              );
            },
            onError: (snapshot) {
              return const SizedBox.shrink();
            },
            onComplete: (context, snapshot) {
              final team = snapshot.data!;
              return Text(
                team.data!.name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                  fontSize: 10,
                ),
              );
            },
          );
  }
}
