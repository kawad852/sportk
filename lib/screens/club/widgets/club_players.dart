import 'package:flutter/material.dart';

class ClubPlayers extends StatefulWidget {
  const ClubPlayers({super.key});

  @override
  State<ClubPlayers> createState() => _ClubPlayersState();
}

class _ClubPlayersState extends State<ClubPlayers> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("club players"),
    );
  }
}