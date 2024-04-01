import 'package:flutter/material.dart';
import 'package:sportk/model/match_plan_model.dart';
import 'package:sportk/model/single_match_event_model.dart' as event;
import 'package:sportk/screens/match_info/widgets/player_card.dart';
import 'package:sportk/screens/player/player_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlanCard extends StatefulWidget {
  final String formation;
  final List<Lineup> lineup;
  final List<Lineup> bench;
  final Coach coach;
  final List<event.Event> substitution;
  const PlanCard({
    super.key,
    required this.formation,
    required this.lineup,
    required this.bench,
    required this.coach,
    required this.substitution,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  List<String> plan = [];
  late int storeIndex;

  void _initializePlan() {
    plan = widget.formation.split("-");
    plan.insert(0, "1");
    widget.lineup.sort((a, b) => a.formationPosition!.compareTo(b.formationPosition!));
  }

  @override
  void initState() {
    super.initState();
    storeIndex = 0;
    _initializePlan();
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plan.length,
                  itemBuilder: (context, index) {
                    final endIndex = widget.lineup.indexOf(widget.lineup[storeIndex]);
                    final part =
                        widget.lineup.sublist(storeIndex, endIndex + int.parse(plan[index]));
                    storeIndex += int.parse(plan[index]);
                    return Center(
                      child: SizedBox(
                        height: plan.length == 5 ? 90 : 100,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          reverse: MySharedPreferences.language != LanguageEnum.arabic,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: int.parse(plan[index]),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(start: 5, end: 10),
                              child: Column(
                                children: [
                                  CustomNetworkImage(
                                    part[index].player!.imagePath!,
                                    width: 47,
                                    height: 47,
                                    shape: BoxShape.circle,
                                    alignment: Alignment.center,
                                    onTap: () => context.push(
                                      PlayerScreen(playerId: part[index].player!.id!),
                                    ),
                                    child: part[index].jerseyNumber == null
                                        ? null
                                        : Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              width: 25,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                color: context.colorPalette.orange,
                                                borderRadius:
                                                    BorderRadius.circular(MyTheme.radiusSecondary),
                                              ),
                                              child: Text(
                                                part[index].jerseyNumber.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: context.colorPalette.white,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      part[index].player!.name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: context.colorPalette.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.appLocalization.coach),
                PlayerCard(
                  playerId: widget.coach.id!,
                  playerImage: widget.coach.imagePath!,
                  playerName: widget.coach.name!,
                ),
              ],
            ),
          ),
          if (widget.substitution.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.appLocalization.substitutions),
                ListView.separated(
                  itemCount: widget.substitution.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => context
                          .push(PlayerScreen(playerId: widget.substitution[index].player!.id!)),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: context.colorPalette.grey3F3,
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              widget.substitution[index].player!.imagePath!,
                              width: 35,
                              height: 35,
                              shape: BoxShape.circle,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: context.colorPalette.greenAD0,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.substitution[index].player!.name!,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_rounded,
                                        color: context.colorPalette.red100,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.substitution[index].relatedPlayerName!,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.appLocalization.bench),
                ListView.separated(
                  itemCount: widget.bench.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PlayerCard(
                      playerId: widget.bench[index].playerId!,
                      playerImage: widget.bench[index].player!.imagePath!,
                      playerName: widget.bench[index].player!.name!,
                      jerseyNumber: widget.bench[index].jerseyNumber,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
