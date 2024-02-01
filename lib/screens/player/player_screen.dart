import 'package:flutter/material.dart';
import 'package:sportk/screens/player/widgets/player_card.dart';
import 'package:sportk/screens/player/widgets/player_statistics.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_back.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.playerUUID});
  final String playerUUID;

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
            leadingWidth: 500,
            pinned: true,
            leading: CustomBack(
              color: context.colorPalette.blueD4B,
              fontWeight: FontWeight.bold,
            ),
            flexibleSpace: Container(
              width: double.infinity,
              height: 234.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.colorPalette.blueD4B, context.colorPalette.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.01, 1.0],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 40),
                child: PlayerCard(uuid: widget.playerUUID),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsetsDirectional.only(start: 15),
            sliver: SliverToBoxAdapter(child: PlayerStatistics()),
          ),
        ],
      ),
    );
  }
}
