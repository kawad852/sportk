import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/model/match_plan_model.dart';
import 'package:sportk/model/single_match_event_model.dart' as event;
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/match_info/widgets/match_live.dart';
import 'package:sportk/screens/match_info/widgets/plan_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/no_results.dart';

class TeamsPlan extends StatefulWidget {
  final int matchId;
  const TeamsPlan({super.key, required this.matchId});

  @override
  State<TeamsPlan> createState() => _TeamsPlanState();
}

class _TeamsPlanState extends State<TeamsPlan> with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin {
  late TabController _controller;
  late FootBallProvider _footBallProvider;
  late Future<MatchPlanModel> _matchPlansFuture;
  bool show = true;

  void _initializeFuture() {
    _matchPlansFuture = _footBallProvider.fetchMatchPlansById(matchId: widget.matchId);
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomFutureBuilder(
      future: _matchPlansFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final matchPlans = snapshot.data!;
        Participant homeTeam = Participant();
        Participant awayTeam = Participant();
        List<Lineup> homeLineup = [];
        List<Lineup> awayLineup = [];
        List<Lineup> homeBench = [];
        List<Lineup> awayBench = [];
        List<event.Event> homeSubstitution = [];
        List<event.Event> awaySubstitution = [];
        Coach homeCoach = Coach();
        Coach awayCoach = Coach();
        String formationHome = "";
        String formationAway = "";

        Future.wait(
          matchPlans.data!.participants!.map((team) async {
            team.meta!.location == LocationEnum.home ? homeTeam = team : awayTeam = team;
          }).toSet(),
        );
        Future.wait(
          matchPlans.data!.formations!.map(
            (formation) async {
              formation.participantId == homeTeam.id
                  ? formationHome = formation.formation!
                  : formationAway = formation.formation!;
            },
          ).toSet(),
        );
        matchPlans.data!.lineups!.map(
          (lineup) {
            if (lineup.typeId == 11 && lineup.formationPosition == null) {
              show = false;
            }
            if (lineup.typeId == 11 && lineup.teamId == homeTeam.id) {
              homeLineup.add(lineup);
            } else if (lineup.typeId == 11 && lineup.teamId == awayTeam.id) {
              awayLineup.add(lineup);
            } else if (lineup.typeId == 12 && lineup.teamId == homeTeam.id) {
              homeBench.add(lineup);
            } else if (lineup.typeId == 12 && lineup.teamId == awayTeam.id) {
              awayBench.add(lineup);
            }
          },
        ).toSet();
        matchPlans.data!.coaches!.map((coach) {
          coach.meta!.participantId == homeTeam.id ? homeCoach = coach : awayCoach = coach;
        }).toSet();
        matchPlans.data!.periods!.map(
          (period) {
            period.events!.map((ev) {
              if (ev.participantId == homeTeam.id && ev.typeId == 18) {
                homeSubstitution.add(ev);
              } else if (ev.participantId == awayTeam.id && ev.typeId == 18) {
                awaySubstitution.add(ev);
              }
            }).toSet();
          },
        ).toSet();
        return matchPlans.data!.lineups!.isEmpty || matchPlans.data!.lineups == null || !show
            ? NoResults(
                header: const Icon(FontAwesomeIcons.baseball),
                title: context.appLocalization.lineupNotAvailable,
              )
            : Column(
                children: [
                  MatchLive(matchId: widget.matchId),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      color: context.colorPalette.grey9E9,
                    ),
                    child: TabBar(
                      controller: _controller,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: context.colorPalette.white,
                      unselectedLabelColor: context.colorPalette.blueD4B,
                      labelPadding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
                      indicator: BoxDecoration(
                        color: context.colorPalette.tabColor,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      tabs: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              homeTeam.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              awayTeam.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        PlanCard(
                          key: UniqueKey(),
                          formation: formationHome,
                          lineup: homeLineup,
                          bench: homeBench,
                          coach: homeCoach,
                          substitution: homeSubstitution,
                        ),
                        PlanCard(
                          key: UniqueKey(),
                          formation: formationAway,
                          lineup: awayLineup,
                          bench: awayBench,
                          coach: awayCoach,
                          substitution: awaySubstitution,
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
