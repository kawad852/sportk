import 'package:flutter/material.dart';
import 'package:sportk/model/team_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class TeamName extends StatefulWidget {
  const TeamName({super.key, required this.teamUUID});
  final String teamUUID;

  @override
  State<TeamName> createState() => _TeamNameState();
}

class _TeamNameState extends State<TeamName> {
  late FootBallProvider _footBallProvider;
  late Future<TeamModel> _teamFuture;
  void _initializeFuture() {
    _teamFuture = _footBallProvider.fetchTeams(uuid: widget.teamUUID);
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
            width: 80,
            height: 15,
            color: context.colorPalette.grey2F2,
          ),
        );
      },
      onComplete: ((context, snapshot) {
        final team = snapshot.data!;
        return Text(
          team.results![0].name!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: context.colorPalette.blueD4B),
        );
      }),
    );
  }
}
