import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/model/match_event_model.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/model/single_match_event_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/match_info/predictions/widgets/viewers_predictions.dart';
import 'package:sportk/screens/match_info/widgets/event_card.dart';
import 'package:sportk/screens/match_info/widgets/statistics_loading.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class MatchEvents extends StatefulWidget {
  final int matchId;
  final int homeId;
  final MatchPointsModel matchPoint;
  const MatchEvents({super.key, required this.matchId, required this.homeId, required this.matchPoint});

  @override
  State<MatchEvents> createState() => _MatchEventsState();
}

class _MatchEventsState extends State<MatchEvents> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
 
  late Future<SingleMatchEventModel> _matchEventFuture;
  List<MatchEventModel> event = [];
  List<MatchEventModel> subEvent = [];

  void _initializeFuture() async {
    _matchEventFuture = _footBallProvider.fetchMatchEventById(matchId: widget.matchId);
  }

  MatchEventEnum getEventType(int typeId) {
    switch (typeId) {
      case 10:
        return MatchEventEnum.varEvent;
      case 14:
        return MatchEventEnum.goal;
      case 15:
        return MatchEventEnum.ownGoal;
      case 16:
      case 23:
        return MatchEventEnum.penaltyScored;
      case 17:
      case 22:
        return MatchEventEnum.penaltyMissed;
      case 18:
        return MatchEventEnum.substitution;
      case 19:
        return MatchEventEnum.yellowCard;
      case 20:
        return MatchEventEnum.redCard;
      case 21:
        return MatchEventEnum.yellowRedCard;
      default:
        return MatchEventEnum.goal;
    }
  }

  String getEventName(int typeId) {
    switch (typeId) {
      case 1:
        return context.appLocalization.half1;
      case 2:
        return context.appLocalization.half2;
      case 3:
        return context.appLocalization.extraTime;
      case 5:
        return context.appLocalization.penalties;
      case 14:
        return context.appLocalization.goal;
      case 15:
        return context.appLocalization.ownGoal;
      case 16:
      case 23:
        return context.appLocalization.penaltyScored;
      case 17:
      case 22:
        return context.appLocalization.penaltyMissed;
      case 19:
        return context.appLocalization.yellowCard;
      case 20:
        return context.appLocalization.redCard;
      case 21:
        return context.appLocalization.yellowRedCard;
      default:
        return "-";
    }
  }

  String getEventVar(String name) {
    switch (name) {
      case VarEnum.goalDisallowed:
      case VarEnum.goalCancelled:
        return context.appLocalization.goalCancelled;
      case VarEnum.penaltyCancelled:
      case VarEnum.penaltyDisallowed:
        return context.appLocalization.penaltyCancelled;
      case VarEnum.penaltyConfirmed:
        return context.appLocalization.penaltyConfirmed;
      case VarEnum.goalConfirmed:
        return context.appLocalization.goalConfirmed;
      case VarEnum.goalUnderReview:
        return context.appLocalization.goalUnderReview;
      default:
        return name;
    }
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder(
      future: _matchEventFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () => const ShimmerLoading(child: StatisticsLoading()),
      onComplete: (context, snapshot) {
        final match = snapshot.data!;
        bool showPrediction = widget.matchPoint.data!.totalPredictions!.home == 0 &&
           widget. matchPoint.data!.totalPredictions!.away == 0 &&
            widget.matchPoint.data!.totalPredictions!.draw == 0;
        if (event.isNotEmpty) {
          event.clear();
          subEvent.clear();
        }
        match.data!.periods!.map(
          (period) {
            event.add(
              MatchEventModel(
                locationEnum: LocationEnum.center,
                matchEventEnum: MatchEventEnum.matchEvent,
                eventName: getEventName(period.typeId!),
              ),
            );

            Future.wait(period.events!.map((e) async {
              subEvent.add(
                MatchEventModel(
                  locationEnum:
                      widget.homeId == e.participantId ? LocationEnum.home : LocationEnum.away,
                  matchEventEnum: getEventType(e.typeId!),
                  minute: e.minute,
                  playerImage: e.player!.imagePath,
                  playerName1: e.player!.name!,
                  playerName2: e.relatedPlayerName,
                  eventName: e.typeId == 10 ? getEventVar(e.addition!) : getEventName(e.typeId!),
                ),
              );
            }).toSet());

            subEvent.sort((a, b) => a.minute!.compareTo(b.minute!));
            event.addAll(subEvent);
            subEvent.clear();
          },
        ).toSet();
        return match.data!.periods!.isEmpty
            ? NoResults(
                header: const Icon(FontAwesomeIcons.baseball),
                title: context.appLocalization.eventsNotAvailable,
              )
            : RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _initializeFuture();
                  });
                },
                child: SingleChildScrollView(
                  physics:const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      if (!showPrediction)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ViewersPredictions(
                            pointsData: widget.matchPoint.data!,
                            totalPredictions:widget. matchPoint.data!.totalPredictions!,
                          ),
                        ),
                      ListView.separated(
                        itemCount: event.length,
                        reverse: true,
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return EventCard(
                            matchEventModel: event[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
