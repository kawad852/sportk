import 'package:flutter/material.dart';
import 'package:sportk/model/groups_standing_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/table_text.dart';
import 'package:sportk/widgets/team_info.dart';

class GroupsStandings extends StatefulWidget {
  final int seasonId;
  final int groupId;
  final int? teamId;
  const GroupsStandings({super.key, required this.seasonId, required this.groupId, this.teamId});

  @override
  State<GroupsStandings> createState() => _GroupsStandingsState();
}

class _GroupsStandingsState extends State<GroupsStandings> {
  late FootBallProvider _footBallProvider;
  late Future<GroupsStandingModel> _groupStandingFuture;

  void _initializeFuture() {
    _groupStandingFuture =
        _footBallProvider.fetchGroupStandings(groupId: widget.groupId, seasonId: widget.seasonId);
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
      future: _groupStandingFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onError: (snapshot) => const SizedBox.shrink(),
      onLoading: () => const ShimmerLoading(
        child: LoadingBubble(
          width: double.infinity,
          height: 50,
          margin: EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 10),
          radius: MyTheme.radiusPrimary,
        ),
      ),
      onComplete: (context, snapshot) {
        final standings = snapshot.data!;
        List<int> teamId = [];
        standings.data!.map(
          (e) {
            teamId.add(e.participantId!);
          },
        ).toSet();
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
          child: ExpansionTile(
            initiallyExpanded: widget.teamId != null && teamId.contains(widget.teamId),
            childrenPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 5),
            backgroundColor: context.colorPalette.white,
            collapsedBackgroundColor: context.colorPalette.white,
            title: Text(standings.data![0].group!.name!),
            shape: const Border(),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                          color: widget.teamId != null && element.participantId == widget.teamId
                              ? context.colorPalette.blueABB
                              : standings.data!.indexOf(element) % 2 == 0
                                  ? context.colorPalette.grey3F3
                                  : context.colorPalette.greyD9D,
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (standings.data!.indexOf(element) == 0 ||
                                  standings.data!.indexOf(element) == 1 ||
                                  standings.data!.indexOf(element) == 2)
                                Container(
                                  width: 5,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: standings.data!.indexOf(element) == 2
                                        ? context.colorPalette.red000
                                        : context.colorPalette.blue1F8,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                                child: Row(
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
                            ],
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
            ],
          ),
        );
      },
    );
  }
}
