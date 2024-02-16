import 'package:flutter/material.dart';
import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

import 'shimmer/shimmer_loading.dart';

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
        return ShimmerLoading(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: context.colorPalette.greenAD0,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  color: context.colorPalette.greenAD0,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        );
      },
      onError: (snapshot) {
        return const SizedBox.shrink();
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
                radius: 0,
              ),
            ),
            SizedBox(
              width: 56,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
      }),
    );
  }
}
