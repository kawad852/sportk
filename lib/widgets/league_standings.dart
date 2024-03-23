import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/model/standings_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/club_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/table_text.dart';
import 'package:sportk/widgets/team_info.dart';

class LeagueStandings extends StatefulWidget {
  final int leagueId;
  final int? selectedTeamId;
  const LeagueStandings({super.key, required this.leagueId, this.selectedTeamId});

  @override
  State<LeagueStandings> createState() => _LeagueStandingsState();
}

class _LeagueStandingsState extends State<LeagueStandings> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<StandingsModel> _standingsFuture;

  void _initializeFuture() {
    _standingsFuture = _footBallProvider.fetchStandings(leagueId: widget.leagueId);
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
      future: _standingsFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final standings = snapshot.data!;
        return standings.data!.isEmpty
            ? NoResults(
                header: const Icon(FontAwesomeIcons.trophy),
                title: context.appLocalization.noStandingsInfo,
              )
            : SingleChildScrollView(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(6.3),
                      1: FlexColumnWidth(1.4),
                      2: FlexColumnWidth(1.4),
                      3: FlexColumnWidth(1.4),
                      4: FlexColumnWidth(1.4),
                      5: FlexColumnWidth(2.8),
                      6: FlexColumnWidth(1.5),
                      7: FlexColumnWidth(1.8),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: context.colorPalette.greyD9D,
                        ),
                        children: [
                          TableText(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            text: context.appLocalization.team,
                          ),
                          TableText(
                            text: context.appLocalization.play,
                          ),
                          TableText(
                            text: context.appLocalization.winner,
                          ),
                          TableText(
                            text: context.appLocalization.draw,
                          ),
                          TableText(
                            text: context.appLocalization.loser,
                          ),
                          TableText(
                            text: context.appLocalization.goals,
                          ),
                          TableText(
                            text: context.appLocalization.differance,
                          ),
                          TableText(
                            text: context.appLocalization.points,
                          ),
                        ],
                      ),
                      ...standings.data!.map((element) {
                        return TableRow(
                          decoration: BoxDecoration(
                            color: widget.selectedTeamId != null &&
                                    element.participantId == widget.selectedTeamId
                                ? context.colorPalette.blueABB
                                : standings.data!.indexOf(element) % 2 == 0
                                    ? context.colorPalette.grey3F3
                                    : context.colorPalette.greyD9D,
                          ),
                          children: [
                            InkWell(
                              onTap: widget.selectedTeamId != null &&
                                      widget.selectedTeamId == element.participantId!
                                  ? null
                                  : () => context.push(
                                        ClubScreen(
                                          teamId: element.participantId!,
                                        ),
                                      ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      element.position?.toString() ?? "",
                                      style: const TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    TeamInfo(
                                      teamId: element.participantId!,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TableText(
                              text: element.details?[0].value?.toString() ?? "",
                            ),
                            TableText(
                              text: element.details?[1].value?.toString() ?? "",
                            ),
                            TableText(
                              text: element.details?[2].value?.toString() ?? "",
                            ),
                            TableText(
                              text: element.details?[3].value?.toString() ?? "",
                            ),
                            TableText(
                              text: "${element.details![4].value}:${element.details![5].value}",
                            ),
                            TableText(
                              text: element.details?[18].value?.toString() ?? "",
                            ),
                            TableText(
                              text: element.points?.toString() ?? "",
                            ),
                          ],
                        );
                      }).toList(),
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
