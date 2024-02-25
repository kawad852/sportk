import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/league_info/widgets/round_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/matches_loading.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueMatches extends StatefulWidget {
  final int leagueId;
  const LeagueMatches({super.key, required this.leagueId});

  @override
  State<LeagueMatches> createState() => _LeagueMatchesState();
}

class _LeagueMatchesState extends State<LeagueMatches> {
  late FootBallProvider _footBallProvider;
  late Future<MatchModel> _matchesFuture;

  void _initializeFuture() {
    _matchesFuture = _footBallProvider.fetchMatchesBetweenTwoDate(
      startDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      endDate: DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 100))),
      leagueId: widget.leagueId,
    );
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
      future: _matchesFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return const ShimmerLoading(child: MatchesLoading());
      },
      onComplete: (context, snapshot) {
        final matches = snapshot.data!;
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _initializeFuture();
            });
          },
          child: SingleChildScrollView(
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
                ...matches.data!.map(
                  (element) {
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
                        if (matches.data!.indexOf(element) == 0 ||
                            (matches.data!.indexOf(element) > 0 &&
                                matches.data![matches.data!.indexOf(element)].roundId !=
                                    matches.data![matches.data!.indexOf(element) - 1].roundId))
                          RoundCard(
                            leagueId: widget.leagueId,
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
                                      if (element.state!.id != 1)
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
                ).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}