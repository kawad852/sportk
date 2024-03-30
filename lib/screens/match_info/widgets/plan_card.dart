import 'package:flutter/material.dart';
import 'package:sportk/model/match_plan_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';

class PlanCard extends StatefulWidget {
  final String formation;
  final List<Lineup> lineup;
  final List<Lineup> bench;
  final Coach coach;
  const PlanCard({
    super.key,
    required this.formation,
    required this.lineup,
    required this.bench,
    required this.coach,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 495,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              image: const DecorationImage(
                image: AssetImage(MyImages.matchPlan),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  margin: const EdgeInsetsDirectional.only(start: 10, top: 10),
                  decoration: BoxDecoration(
                    color: context.colorPalette.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                  ),
                  child: Text(
                    widget.formation,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorPalette.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
