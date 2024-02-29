import 'package:flutter/material.dart';
import 'package:sportk/model/matches/our_teams_model.dart';
import 'package:sportk/widgets/team_bubble.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("League"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: 30,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return TeamBubble(team: TeamData());
        },
      ),
    );
  }
}
