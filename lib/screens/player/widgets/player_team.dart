import 'package:flutter/material.dart';
import 'package:sportk/model/team_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerTeam extends StatefulWidget {
  const PlayerTeam({super.key, required this.teamUUID});
  final String teamUUID;

  @override
  State<PlayerTeam> createState() => _PlayerTeamState();
}

class _PlayerTeamState extends State<PlayerTeam> {
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
        return context.loaders.circular(isSmall: true);
      },
      onComplete: ((context, snapshot) {
        final team = snapshot.data!;
        return Stack(
          children: [
            CustomNetworkImage(
              team.results![0].logo!,
              width: 30,
              height: 30,
              radius: 0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 25, start: 5),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: context.colorPalette.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "9",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
