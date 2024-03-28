import 'package:flutter/material.dart';
import 'package:sportk/model/match_event_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class EventCard extends StatefulWidget {
  final MatchEventModel matchEventModel;
  const EventCard({super.key, required this.matchEventModel});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool get _isCenter => widget.matchEventModel.locationEnum == LocationEnum.center;
  bool get _isHome => widget.matchEventModel.locationEnum == LocationEnum.home;
  MatchEventModel get _matchEventModel => widget.matchEventModel;

  bool get _isSpecialEvent =>
      _matchEventModel.matchEventEnum == MatchEventEnum.varEvent ||
      _matchEventModel.matchEventEnum == MatchEventEnum.penaltyMissed ||
      _matchEventModel.matchEventEnum == MatchEventEnum.penaltyScored;

  String getIcon(MatchEventEnum matchEventEnum) {
    switch (matchEventEnum) {
      case MatchEventEnum.varEvent:
        return MyIcons.varEvent;
      case MatchEventEnum.goal:
      case MatchEventEnum.ownGoal:
        return MyIcons.goals;
      case MatchEventEnum.penaltyScored:
        return MyIcons.penaltyScored;
      case MatchEventEnum.penaltyMissed:
        return MyIcons.penaltyMissed;
      case MatchEventEnum.substitution:
        return MyIcons.substitution;
      case MatchEventEnum.yellowCard:
        return MyIcons.yellowCard;
      case MatchEventEnum.redCard:
        return MyIcons.redCard;
      case MatchEventEnum.yellowRedCard:
        return MyIcons.yellowRedCard;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: _isCenter
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomSvg(MyIcons.matchEvent),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  _matchEventModel.eventName ?? "",
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                  ),
                ),
              ],
            )
          : _isHome
              ? Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          _isSpecialEvent
                              ? CustomSvg(
                                  getIcon(_matchEventModel.matchEventEnum),
                                  fixedColor: true,
                                )
                              : CustomNetworkImage(
                                  _matchEventModel.playerImage ?? "",
                                  width: 45,
                                  height: 40,
                                  shape: BoxShape.circle,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: CustomSvg(
                                      getIcon(_matchEventModel.matchEventEnum),
                                      fixedColor: true,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _matchEventModel.matchEventEnum == MatchEventEnum.substitution
                                      ? _matchEventModel.playerName2!
                                      : _matchEventModel.eventName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _matchEventModel.playerName1 ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _matchEventModel.matchEventEnum ==
                                            MatchEventEnum.substitution
                                        ? context.colorPalette.green057
                                        : context.colorPalette.blueD4B,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${_matchEventModel.minute ?? ""}",
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                      ),
                    ),
                    const Expanded(flex: 2, child: Text("")),
                  ],
                )
              : Row(
                  children: [
                    const Expanded(flex: 2, child: Text("")),
                    Text(
                      "${_matchEventModel.minute ?? ""}",
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _matchEventModel.matchEventEnum == MatchEventEnum.substitution
                                      ? _matchEventModel.playerName2!
                                      : _matchEventModel.eventName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _matchEventModel.playerName1 ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _matchEventModel.matchEventEnum ==
                                            MatchEventEnum.substitution
                                        ? context.colorPalette.green057
                                        : context.colorPalette.blueD4B,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          _isSpecialEvent
                              ? CustomSvg(
                                  getIcon(_matchEventModel.matchEventEnum),
                                  fixedColor: true,
                                )
                              : CustomNetworkImage(
                                  _matchEventModel.playerImage ?? "",
                                  width: 45,
                                  height: 40,
                                  shape: BoxShape.circle,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: CustomSvg(
                                      getIcon(_matchEventModel.matchEventEnum),
                                      fixedColor: true,
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
