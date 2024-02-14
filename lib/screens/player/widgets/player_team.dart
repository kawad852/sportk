import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerTeam extends StatefulWidget {
  const PlayerTeam({super.key, required this.teamId, required this.jerseyNumber});
  final int? teamId;
  final int? jerseyNumber;

  @override
  State<PlayerTeam> createState() => _PlayerTeamState();
}

class _PlayerTeamState extends State<PlayerTeam> {
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
              return context.loaders.circular(isSmall: true);
            },
            onComplete: ((context, snapshot) {
              final team = snapshot.data!;
              return Column(
                children: [
                  Stack(
                    children: [
                      CustomNetworkImage(
                        team.data!.imagePath!,
                        width: 30,
                        height: 30,
                        radius: 0,
                      ),
                      if (widget.jerseyNumber != null)
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
                              widget.jerseyNumber.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.colorPalette.blueD4B,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }),
          );
  }
}
