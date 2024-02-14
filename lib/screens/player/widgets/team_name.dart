import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class TeamName extends StatefulWidget {
  const TeamName({super.key, required this.teamId});
  final int teamId;

  @override
  State<TeamName> createState() => _TeamNameState();
}

class _TeamNameState extends State<TeamName> {
  late FootBallProvider _footBallProvider;
  late Future<TeamInfoModel> _teamFuture;
  void _initializeFuture() {
    _teamFuture = _footBallProvider.fetchTeamInfo(teamId: widget.teamId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _teamFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return ShimmerLoading(
          child: Container(
            width: 40,
            height: 9,
            color: context.colorPalette.grey2F2,
          ),
        );
      },
      onComplete: ((context, snapshot) {
        final team = snapshot.data!;
        return Text(
          team.data!.name!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: context.colorPalette.blueD4B,
            fontSize: 10,
          ),
        );
      }),
    );
  }
}
