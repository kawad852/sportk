import 'package:flutter/material.dart';
import 'package:sportk/model/player_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/player_team/widgets/player_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class PlayerTeamScreen extends StatefulWidget {
  const PlayerTeamScreen({super.key, required this.uuid});
  final String uuid;

  @override
  State<PlayerTeamScreen> createState() => _PlayerTeamScreenState();
}

class _PlayerTeamScreenState extends State<PlayerTeamScreen> {
  late FootBallProvider _footBallProvider;
  late Future<PlayerModel> _playerFuture;

  void _initializeFuture() {
    _playerFuture = _footBallProvider.fetchPlayerInfo(uuid: widget.uuid);
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
      onComplete: ((context, snapshot) {
        final player = snapshot.data!;
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
                    padding: const EdgeInsetsDirectional.only(bottom: 50),
                    child: PlayerCard(player: player),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
