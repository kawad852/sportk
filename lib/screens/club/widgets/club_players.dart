// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:sportk/model/squads_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/widgets/club_players_loading.dart';
import 'package:sportk/screens/player/player_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class ClubPlayers extends StatefulWidget {
  final int teamId;
  const ClubPlayers({super.key, required this.teamId});

  @override
  State<ClubPlayers> createState() => _ClubPlayersState();
}

class _ClubPlayersState extends State<ClubPlayers> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<SquadsModel> _squadsFuture;
  void _initializeFuture() {
    _squadsFuture = _footBallProvider.fetchSquads(teamId: widget.teamId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<String> playersName = [
      context.appLocalization.attackers,
      context.appLocalization.midline,
      context.appLocalization.defenders,
      context.appLocalization.guards
    ];
    final List<Datum> _attackers = [], _midline = [], _defenders = [], _guards = [];

    void checkPlayerPosition(Datum element) {
      switch ([element.detailedPositionId, element.positionId]) {
        case ([24, 24]):
          _guards.add(element);

        case ([25, 25] || [148, 25] || [154, 25] || [155, 25]):
          _defenders.add(element);

        case ([26, 26] || [149, 26] || [150, 26] || [153, 26] || [157, 26] || [158, 26]):
          _midline.add(element);

        case ([27, 27] || [151, 27] || [152, 27] || [156, 27] || [163, 27]):
          _attackers.add(element);

        default:
          _midline.add(element);
      }
    }

    return CustomFutureBuilder(
      future: _squadsFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return const ShimmerLoading(
          child: ClubPlayersLoading(),
        );
      },
      onComplete: (context, snapshot) {
        final squads = snapshot.data!;
        squads.data!.map(
          (element) {
            checkPlayerPosition(element);
          },
        ).toSet();
        final List<List<Datum>> players = [_attackers, _midline, _defenders, _guards];

        return SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: players.length,
            itemBuilder: (BuildContext context, int index) {
              return players[index].isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 30.0,
                          margin: const EdgeInsetsDirectional.only(bottom: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.colorPalette.blue4F0,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            playersName[index],
                            style: TextStyle(
                              color: context.colorPalette.blueD4B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: players[index].length,
                          itemBuilder: (BuildContext context, int myIndex) {
                            return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                context.push(PlayerScreen(
                                  playerId: players[index][myIndex].playerId!,
                                ));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                                margin: const EdgeInsetsDirectional.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: context.colorPalette.grey3F3,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CustomNetworkImage(
                                            players[index][myIndex].player!.imagePath!,
                                            width: 35.0,
                                            height: 35.0,
                                            shape: BoxShape.circle,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            width: 220,
                                            child: Text(
                                              players[index][myIndex].player!.displayName!,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: context.colorPalette.grey9E9,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          players[index][myIndex].jerseyNumber?.toString() ?? "-",
                                          style: TextStyle(
                                            color: context.colorPalette.blueD4B,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
