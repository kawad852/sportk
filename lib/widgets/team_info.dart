import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class TeamInfo extends StatefulWidget {
  const TeamInfo({super.key, required this.teamId});
  final int teamId;

  @override
  State<TeamInfo> createState() => _TeamInfoState();
}

class _TeamInfoState extends State<TeamInfo> {
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
          return context.loaders.circular(isSmall: true);
        },
        onComplete: ((context, snapshot) {
          final team = snapshot.data!;
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: CustomNetworkImage(
                  team.data!.imagePath!,
                  width: 20,
                  height: 20,
                ),
              ),
              SizedBox(
                width: 56,
                child: Column(
                  children: [
                    Text(
                      team.data!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
