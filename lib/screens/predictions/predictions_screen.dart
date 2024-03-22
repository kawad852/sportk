import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/model/prediction_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/predictions/widgets/container_card.dart';
import 'package:sportk/screens/predictions/widgets/predictions_card.dart';
import 'package:sportk/screens/predictions/widgets/predictions_container.dart';
import 'package:sportk/screens/predictions/widgets/result_picker.dart';
import 'package:sportk/screens/predictions/widgets/team_name.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/stretch_button.dart';

class PredictionsScreen extends StatefulWidget {
  final PointsData pointsData;
  const PredictionsScreen({super.key, required this.pointsData});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  int _selectedWinning = 0;
  int _selectedFirstScore = 0;
  bool _visibleResult = false;
  bool _visibleFirstScore = false;
  int _homeScore = 1;
  int _awayScore = 1;
  late String _firstScoreId;
  late String _prediction;

  PointsData get pointData => widget.pointsData;

  late CommonProvider _commonProvider;

  void createPrediction() {
    ApiFutureBuilder<PredictionModel>().fetch(
      context,
      future: () async {
        final prediction = _commonProvider.createPrediction(
          matchId: pointData.matchId!,
          homeScore: _homeScore.toString(),
          awayScore: _awayScore.toString(),
          firstScoreId: _firstScoreId,
          prediction: _prediction,
        );
        return prediction;
      },
      onComplete: (snapshot) {
        context.showSnackBar(context.appLocalization.successPrediction);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _firstScoreId = pointData.homeId!;
    _prediction = pointData.homeId!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Visibility(
        visible: _visibleFirstScore,
        child: ZoomIn(
          child: StretchedButton(
            onPressed: () {
              createPrediction();
            },
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(context.appLocalization.confirm),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              context.appLocalization.predictAndWin,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                PredictionsCard(
                  predictionText: context.appLocalization.predTeamWin(pointData.teamsScorePoints!),
                ),
                const SizedBox(
                  height: 10,
                ),
                ContainerCard(
                  height: 120,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedWinning = index;
                            if (!_visibleResult) {
                              _visibleResult = true;
                            }
                            switch (index) {
                              case 0:
                                _prediction = pointData.homeId!;
                              case 1:
                                _prediction = "draw";
                              case 2:
                                _prediction = pointData.awayId!;
                            }
                          });
                        },
                        child: PredictionsContainer(
                          index: index,
                          teamLogo: index == 0 ? pointData.homeLogo! : pointData.awayLogo!,
                          team: index == 0 ? pointData.homeName! : pointData.awayName!,
                          isDraw: index == 1 ? true : false,
                          selectedCard: _selectedWinning,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Visibility(
                visible: _visibleResult,
                child: Column(
                  children: [
                    PredictionsCard(
                      predictionText:
                          context.appLocalization.predResult(pointData.matchResultPoints!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ContainerCard(
                      height: 75,
                      child: Row(
                        children: [
                          TeamName(name: pointData.homeName!),
                          ResultPicker(onSelectedItemChanged: (value) {
                            setState(() {
                              if (!_visibleFirstScore) {
                                _visibleFirstScore = true;
                              }
                              _homeScore = value;
                            });
                          }),
                          VerticalDivider(
                            color: context.colorPalette.greyAAA,
                            thickness: 2,
                            indent: 15,
                            endIndent: 20,
                          ),
                          ResultPicker(onSelectedItemChanged: (value) {
                            setState(() {
                              if (!_visibleFirstScore) {
                                _visibleFirstScore = true;
                              }
                              _awayScore = value;
                            });
                          }),
                          TeamName(name: pointData.awayName!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: _visibleFirstScore,
              child: Column(
                children: [
                  PredictionsCard(
                    predictionText:
                        context.appLocalization.predFirstScore(pointData.firstScorerPoints!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ContainerCard(
                    height: 120,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedFirstScore = index;
                            });
                            _firstScoreId = index == 0 ? pointData.homeId! : pointData.awayId!;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: PredictionsContainer(
                              index: index,
                              teamLogo: index == 0 ? pointData.homeLogo! : pointData.awayLogo!,
                              team: index == 0 ? pointData.homeName! : pointData.awayName!,
                              selectedCard: _selectedFirstScore,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
