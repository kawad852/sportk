import 'package:flutter/material.dart';

class TeamName extends StatelessWidget {
  final String name;
  const TeamName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
