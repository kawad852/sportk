import 'package:flutter/material.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/champions_league/widgets/stage_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class ChampionsMatches extends StatefulWidget {
  const ChampionsMatches({super.key});

  @override
  State<ChampionsMatches> createState() => _ChampionsMatchesState();
}

class _ChampionsMatchesState extends State<ChampionsMatches> {
  late FootBallProvider _footBallProvider;
  late Future<MatchModel> _matchesFuture;

  void _initializeFuture() {
    _matchesFuture = _footBallProvider.fetchMatchesBetweenTwoDate(
        startDate: "2024-02-23", endDate: "2024-03-23", leagueId: 2);
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
        return ShimmerLoading(
          child:Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
            child: Column(),
          )
          );
      },
      onComplete: (context, snapshot) {
        final matches = snapshot.data!;
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
              ...matches.data!.map(
                (element) {
                  return Column(
                    children: [
                      StageCard(stageId: element.stageId!),
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
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
                              child: Text(
                                "05/01/2024",
                                style: TextStyle(
                                  color: context.colorPalette.green057,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            CustomNetworkImage(
                              element.participants![1].imagePath!,
                              width: 30,
                              height: 30,
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
        );
      },
    );
  }
}
