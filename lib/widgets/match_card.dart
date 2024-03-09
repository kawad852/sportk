import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/match_timer_circle.dart';

class MatchCard extends StatefulWidget {
  final MatchData element;

  const MatchCard({
    super.key,
    required this.element,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    int homeGoals = 0;
    int awayGoals = 0;
    int? minute;
    int? timeAdded;
    List<double> goalsTime = [];
    Participant teamHome = Participant();
    Participant teamAway = Participant();
    widget.element.periods!.map((period) {
      if (period.hasTimer! && (period.typeId == 2 || period.typeId == 1)) {
        minute = period.minutes;
        timeAdded = period.timeAdded;
      } else if (period.hasTimer! && period.typeId == 3) {
        minute = period.minutes;
        timeAdded = period.timeAdded == null ? 30 : 30 + period.timeAdded!;
      }
      period.events!.map((event) {
        if (event.typeId == 14 || event.typeId == 16) {
          goalsTime.add(event.minute!.toDouble());
        }
      }).toSet();
    }).toSet();
    widget.element.statistics!.map(
      (e) {
        if (e.typeId == 52) {
          switch (e.location) {
            case LocationEnum.home:
              homeGoals = e.data!.value!;
            case LocationEnum.away:
              awayGoals = e.data!.value!;
          }
        }
      },
    ).toSet();
    widget.element.participants!.map((e) {
      if (e.meta!.location == LocationEnum.home) {
        teamHome = e;
      } else {
        teamAway = e;
      }
    }).toSet();
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.blueE2F,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              teamHome.name!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          CustomNetworkImage(
            teamHome.imagePath!,
            width: 30,
            height: 30,
            shape: BoxShape.circle,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.element.state!.id != 1 &&
                        widget.element.state!.id != 13 &&
                        widget.element.state!.id != 10
                    ? Text(
                        "$homeGoals",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    : const SizedBox(
                        width: 6,
                      ),
                widget.element.state!.id == 3
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                        child: MatchTimerCircle(
                          currentTime: 45,
                          goalsTime: goalsTime,
                          timeAdded: 0,
                          isHalfTime: true,
                        ),
                      )
                    : minute != null
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
                            child: MatchTimerCircle(
                              currentTime: minute!.toDouble(),
                              goalsTime: goalsTime,
                              timeAdded: timeAdded,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                child: Text(
                                  widget.element.state!.name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context.colorPalette.green057,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              if (widget.element.state!.id == 1)
                                Text(
                                  DateFormat("yyyy-MM-dd").format(widget.element.startingAt!),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (widget.element.state!.id == 1)
                                Text(
                                  DateFormat("HH:mm").format(widget.element.startingAt!),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                widget.element.state!.id != 1 &&
                        widget.element.state!.id != 13 &&
                        widget.element.state!.id != 10
                    ? Text(
                        "$awayGoals",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    : const SizedBox(
                        width: 6,
                      )
              ],
            ),
          ),
          CustomNetworkImage(
            teamAway.imagePath!,
            width: 30,
            height: 30,
            shape: BoxShape.circle,
          ),
          Expanded(
            flex: 1,
            child: Text(
              teamAway.name!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
