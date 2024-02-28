import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/widgets/phase_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/matches_loading.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class ClubMatches extends StatefulWidget {
  final int teamId;
  const ClubMatches({super.key, required this.teamId});

  @override
  State<ClubMatches> createState() => _ClubMatchesState();
}

class _ClubMatchesState extends State<ClubMatches> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<MatchModel> _matchesFuture;
  final _vexKey = GlobalKey<VexPaginatorState>();

  Future<MatchModel> _initializeFuture(int pageKey) {
    _matchesFuture = _footBallProvider.fetchTeamMatchesBetweenTwoDate(
      startDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      endDate: DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 100))),
      teamId: widget.teamId,
      pageKey: pageKey,
    );
    return _matchesFuture;
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _vexKey.currentState!.refresh();
        });
      },
      child: VexPaginator(
        key: _vexKey,
        query: (pageKey) async => _initializeFuture(pageKey),
        onFetching: (snapshot) async => snapshot.data!,
        pageSize: 25,
        onLoading: () {
          return const ShimmerLoading(child: MatchesLoading());
        },
        builder: (context, snapshot) {
          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.appLocalization.nextMatches,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  itemCount: snapshot.docs.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                      return const VexLoader();
                    }
                    final matches = snapshot.docs as List<MatchData>;
                    final element = matches[index];
                    int homeGoals = 0;
                    int awayGoals = 0;
                    element.statistics!.map(
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
                    return Column(
                      children: [
                        PhaseCard(
                          teamId: widget.teamId,
                          stageId: element.stageId!,
                          leagueId: element.leagueId!,
                          roundId: element.roundId,
                        ),
                        Container(
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
                                  element.participants![0].name!,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: context.colorPalette.blueD4B),
                                ),
                              ),
                              CustomNetworkImage(
                                element.participants![0].imagePath!,
                                width: 30,
                                height: 30,
                                shape: BoxShape.circle,
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (element.state!.id != 1 &&
                                          element.state!.id != 13 &&
                                          element.state!.id != 10)
                                        Text("$homeGoals   :   $awayGoals"),
                                      Text(
                                        element.state!.name!,
                                        style: TextStyle(
                                          color: context.colorPalette.green057,
                                          fontSize: 8,
                                        ),
                                      ),
                                      Text(
                                        DateFormat("yyyy-MM-dd").format(element.startingAt!),
                                        style: const TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                      if (element.state!.id == 1)
                                        Text(
                                          DateFormat("HH:mm").format(element.startingAt!),
                                          style: const TextStyle(
                                            fontSize: 8,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomNetworkImage(
                                element.participants![1].imagePath!,
                                width: 30,
                                height: 30,
                                shape: BoxShape.circle,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  element.participants![1].name!,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: context.colorPalette.blueD4B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
