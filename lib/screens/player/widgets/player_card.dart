import 'package:flutter/material.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/player_card_loading.dart';
import 'package:sportk/screens/player/widgets/player_team.dart';
import 'package:sportk/widgets/team_name.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard({super.key, required this.playerId});
  final int playerId;

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  late FootBallProvider _footBallProvider;
  late Future<PlayerModel> _playerFuture;

  void _initializeFuture() {
    _playerFuture = _footBallProvider.fetchPlayerInfo(playerId: widget.playerId);
  }

  int getAeg(DateTime date) {
    return DateTime.now().year - date.year;
  }

  String getPosition(int? id, int? parentId) {
    switch ([id, parentId]) {
      case ([24, 24]):
        return context.appLocalization.goalKeeper;
      case ([25, 25]):
        return context.appLocalization.defender;
      case ([26, 26]):
        return context.appLocalization.midfielder;
      case ([27, 27]):
        return context.appLocalization.attacker;
      case ([28, 28]):
        return context.appLocalization.unknown;
      case ([148, 25]):
        return context.appLocalization.centreBack;
      case ([149, 26]):
        return context.appLocalization.defensiveMidfield;
      case ([150, 26]):
        return context.appLocalization.attackingMidfield;
      case ([151, 27]):
        return context.appLocalization.centreForward;
      case ([152, 27]):
        return context.appLocalization.leftWing;
      case ([153, 26]):
        return context.appLocalization.centralMidfield;
      case ([154, 25]):
        return context.appLocalization.rightBack;
      case ([155, 25]):
        return context.appLocalization.leftBack;
      case ([156, 27]):
        return context.appLocalization.rightWing;
      case ([157, 26]):
        return context.appLocalization.leftMidfield;
      case ([158, 26]):
        return context.appLocalization.rightMidfield;
      case ([163, 27]):
        return context.appLocalization.secondaryStriker;
      case ([221, 221]):
        return context.appLocalization.coach;
      default:
        return context.appLocalization.unknown;
    }
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
      future: _playerFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return const ShimmerLoading(child: PlayerCardLoading());
      },
      onComplete: ((context, snapshot) {
        final player = snapshot.data!;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerTeam(
                  teamId: player.data!.teams!.isEmpty ? null : player.data!.teams![0].teamId,
                  jerseyNumber:
                      player.data!.teams!.isEmpty ? null : player.data!.teams![0].jerseyNumber,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Column(
                    children: [
                      CustomNetworkImage(
                        player.data!.imagePath!,
                        width: 60,
                        height: 60,
                        radius: 5,
                      ),
                    ],
                  ),
                ),
                PlayerTeam(
                  teamId: player.data!.teams!.length == 2 ? player.data!.teams![1].teamId : null,
                  jerseyNumber:
                      player.data!.teams!.length == 2 ? player.data!.teams![1].jerseyNumber : null,
                ),
              ],
            ),
            Text(
              player.data!.name!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: context.colorPalette.blueD4B),
            ),
            TeamName(
              teamId: player.data!.teams!.isEmpty ? null : player.data!.teams![0].teamId,
            ),
            TeamName(
              teamId: player.data!.teams!.length == 2 ? player.data!.teams![1].teamId : null,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: context.colorPalette.grey3F3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getPosition(player.data!.detailedPositionId, player.data!.positionId),
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            context.appLocalization.position,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: context.colorPalette.grey3F3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.data!.dateOfBirth == null
                                ? context.appLocalization.unknown
                                : "${getAeg(player.data!.dateOfBirth!)} ${context.appLocalization.year}",
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            context.appLocalization.age,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: context.colorPalette.grey3F3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.data!.weight == null
                                ? context.appLocalization.unknown
                                : "${player.data!.weight} ${context.appLocalization.kg}",
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            context.appLocalization.weight,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: context.colorPalette.grey3F3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.data!.height == null
                                ? context.appLocalization.unknown
                                : "${player.data!.height} ${context.appLocalization.cm}",
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            context.appLocalization.height,
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
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
