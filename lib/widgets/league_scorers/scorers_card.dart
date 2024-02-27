import 'package:flutter/material.dart';
import 'package:sportk/model/top_scorers_model.dart';
import 'package:sportk/screens/player/player_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/league_scorers/penalty.dart';
import 'package:sportk/widgets/team_name.dart';

class ScorersCard extends StatefulWidget {
  final TopScoreData topScoreData;
  const ScorersCard({super.key, required this.topScoreData});

  @override
  State<ScorersCard> createState() => _ScorersCardState();
}

class _ScorersCardState extends State<ScorersCard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: context.colorPalette.grey3F3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () => context.push(PlayerScreen(playerId: widget.topScoreData.player!.id!)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.topScoreData.position.toString(),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        widget.topScoreData.player!.imagePath!,
                        width: 35,
                        height: 35,
                        shape: BoxShape.circle,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.topScoreData.player!.displayName!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: context.colorPalette.blueD4B,
                                fontSize: 12,
                              ),
                            ),
                            TeamName(
                              teamId: widget.topScoreData.participantId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.topScoreData.total.toString(),
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Penalty(
                    playerId: widget.topScoreData.playerId!,
                    seasonId: widget.topScoreData.seasonId!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
