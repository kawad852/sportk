import 'package:flutter/material.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player/widgets/player_card.dart';
import 'package:sportk/screens/player/widgets/player_statistics.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.playerId});
  final int playerId;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late FootBallProvider _footBallProvider;
  late Future<PlayerModel> _playerFuture;

  void _initializeFuture() {
    _playerFuture = _footBallProvider.fetchPlayerInfo(playerId: widget.playerId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

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
                child: PlayerCard(playerId: widget.playerId),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.only(start: 15),
            sliver: SliverToBoxAdapter(
              child: CustomFutureBuilder(
                future: _playerFuture,
                onRetry: () {
                  setState(
                    () {
                      _initializeFuture();
                    },
                  );
                },
                onLoading: () {
                  return const SizedBox.shrink();
                },
                onComplete: ((context, snapshot) {
                  return PlayerStatistics(
                    playerId: widget.playerId,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
