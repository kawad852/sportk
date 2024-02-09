import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';

class LeagueLoading extends StatelessWidget {
  const LeagueLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 65),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: context.colorPalette.grey2F2,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 50,
            height: 20,
            decoration: BoxDecoration(
              color: context.colorPalette.grey2F2,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
