import 'package:flutter/material.dart';

class ClubStandings extends StatefulWidget {
  const ClubStandings({super.key});

  @override
  State<ClubStandings> createState() => _ClubStandingsState();
}

class _ClubStandingsState extends State<ClubStandings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("club standings"),
    );
  }
}