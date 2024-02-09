import 'package:flutter/material.dart';
import 'package:sportk/model/standings_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/team_info.dart';

class LeagueStandings extends StatefulWidget {
  const LeagueStandings({super.key, required this.leagueId});
  final int leagueId;

  @override
  State<LeagueStandings> createState() => _LeagueStandingsState();
}

class _LeagueStandingsState extends State<LeagueStandings> {
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
    return CustomFutureBuilder(
      future: _standingsFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return ShimmerLoading(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: context.colorPalette.grey2F2,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
      onComplete: ((context, snapshot) {
        final standings = snapshot.data!;
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
          child: SingleChildScrollView(
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Text(
                        context.appLocalization.team,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.play,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.winner,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.draw,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.loser,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.goals,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.differance,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        context.appLocalization.points,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                ...standings.data!.map((element) {
                  return TableRow(
                    decoration: BoxDecoration(
                      color: standings.data!.indexOf(element) % 2 == 0
                          ? context.colorPalette.grey3F3
                          : context.colorPalette.greyD9D,
                      borderRadius: standings.data!.indexOf(element) == standings.data!.length - 1
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                          : null,
                    ),
                    children: [
                      Padding(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          element.details?[0].value?.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          element.details?[1].value?.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          element.details?[2].value?.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          element.details?[3].value?.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "${element.details![4].value}:${element.details![5].value}",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          element.details?[18].value?.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          element.points?.toString() ?? "",
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
