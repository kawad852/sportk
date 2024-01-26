import 'package:flutter/material.dart';
import 'package:sportk/model/team_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class TeamWidget extends StatefulWidget {
  final String teamId;
  final bool reverse;

  const TeamWidget({
    super.key,
    required this.teamId,
    required this.reverse,
  });

  @override
  State<TeamWidget> createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  late FootBallProvider _footBallProvider;
  late Future<TeamModel> _teamFuture;

  void _initializeFuture() {
    _teamFuture = _footBallProvider.fetchTeams(uuid: widget.teamId);
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
      onRetry: () {},
      onError: (snapshot) {
        return const SizedBox.shrink();
      },
      onLoading: () {
        return SizedBox(
          width: 100,
          child: context.loaders.circular(isSmall: true),
        );
      },
      onComplete: (context, snapshot) {
        final team = snapshot.data!;
        final result = team.results!.first;
        if (widget.reverse) {
          return Row(
            children: [
              CustomNetworkImage(
                result.logo!,
                radius: 0,
                width: 25,
                height: 25,
                margin: const EdgeInsetsDirectional.only(end: 10, start: 6),
              ),
              Text(result.name!),
            ],
          );
        } else {
          return Row(
            children: [
              Text(result.name!),
              CustomNetworkImage(
                result.logo!,
                radius: 0,
                width: 25,
                height: 25,
                margin: const EdgeInsetsDirectional.only(start: 10, end: 6),
              ),
            ],
          );
        }
      },
    );
  }
}
