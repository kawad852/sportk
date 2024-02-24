import 'package:flutter/material.dart';
import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/team_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class TeamWidget extends StatefulWidget {
  final Participant participant;
  final bool reverse;

  const TeamWidget({
    super.key,
    required this.participant,
    required this.reverse,
  });

  @override
  State<TeamWidget> createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  late FootBallProvider _footBallProvider;
  late Future<TeamModel> _teamFuture;

  Participant get _participant => widget.participant;

  void _initializeFuture() {
    // _teamFuture = _footBallProvider.fetchTeams(uuid: widget.teamId);
    _teamFuture = Future.value(TeamModel());
  }

  Widget _buildText(String text, TextAlign textAlign) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        overflow: TextOverflow.ellipsis,
      ),
      textAlign: textAlign,
    );
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomFutureBuilder(
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
          if (widget.reverse) {
            return Row(
              children: [
                CustomNetworkImage(
                  _participant.imagePath!,
                  radius: 0,
                  width: 25,
                  height: 25,
                  margin: const EdgeInsetsDirectional.only(end: 10, start: 6),
                ),
                Expanded(child: _buildText(_participant.name!, TextAlign.start)),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: _buildText(_participant.name!, TextAlign.end),
                ),
                CustomNetworkImage(
                  _participant.imagePath!,
                  radius: 0,
                  width: 25,
                  height: 25,
                  margin: const EdgeInsetsDirectional.only(start: 10, end: 6),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
