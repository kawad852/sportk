import 'package:flutter/material.dart';
import 'package:sportk/screens/player/player_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerCard extends StatelessWidget {
  final String playerName;
  final String playerImage;
  final int? jerseyNumber;
  final int playerId;
  const PlayerCard(
      {super.key,
      required this.playerName,
      required this.playerImage,
      required this.playerId,
      this.jerseyNumber});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(PlayerScreen(playerId: playerId)),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: context.colorPalette.grey3F3,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Row(
          children: [
            CustomNetworkImage(
              playerImage,
              width: 35,
              height: 35,
              shape: BoxShape.circle,
              child: jerseyNumber == null
                  ? null
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: context.colorPalette.orange,
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: Text(
                          jerseyNumber.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: context.colorPalette.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                playerName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.colorPalette.blueD4B,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
