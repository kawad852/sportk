import 'package:flutter/material.dart';
import 'package:sportk/screens/player/widgets/player_card.dart';
import 'package:sportk/screens/player/widgets/player_statistics.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_back.dart';

class PlayerScreen extends StatefulWidget {
  final int playerId;
  const PlayerScreen({super.key, required this.playerId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: kBarLeadingWith,
            pinned: true,
            collapsedHeight: kBarCollapsedHeight,
            leading: CustomBack(
              color: context.colorPalette.blueD4B,
              fontWeight: FontWeight.bold,
            ),
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    MyTheme.isLightTheme(context)
                        ? MyImages.linearPlayer
                        : MyImages.linearPlayerDark,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 30),
                child: PlayerCard(playerId: widget.playerId),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.only(start: 15),
            sliver: SliverToBoxAdapter(
              child: PlayerStatistics(
                playerId: widget.playerId,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
