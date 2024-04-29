import 'package:flutter/material.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/model/prediction_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/match_info/predictions/widgets/container_card.dart';
import 'package:sportk/screens/match_info/predictions/widgets/predictions_card.dart';
import 'package:sportk/screens/match_info/predictions/widgets/predictions_container.dart';
import 'package:sportk/screens/match_info/predictions/widgets/result_picker.dart';
import 'package:sportk/screens/match_info/predictions/widgets/team_name.dart';
import 'package:sportk/screens/match_info/predictions/widgets/viewers_predictions.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';

class PredictionsScreen extends StatefulWidget {
  final PointsData pointsData;
  const PredictionsScreen({super.key, required this.pointsData});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> with AutomaticKeepAliveClientMixin {
  late ScrollController controller;
  int _selectedWinning = 3;
  int _selectedFirstScore = 3;
  bool _visibleResult = false;
  bool _visibleFirstScore = false;
  int _homeScore = 1;
  int _awayScore = 1;
  late String _firstScoreId;
  late String _prediction;

  PointsData get pointData => widget.pointsData;
  late TotalPredictions totalPredictions;

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
        context.showSnackBar(
          snapshot.code == 500 ? context.appLocalization.alreadyPrediction : context.appLocalization.successPrediction,
        );
        if (snapshot.code == 200) {
          setState(() {
            if (pointData.resultDisplay == PredictionTypeEnum.count) {
              totalPredictions = TotalPredictions(
                home: _prediction == pointData.homeId ? totalPredictions.home! + 1 : totalPredictions.home,
                away: _prediction == pointData.awayId ? totalPredictions.away! + 1 : totalPredictions.away,
                draw: _prediction == "draw" ? totalPredictions.draw! + 1 : totalPredictions.draw,
              );
            } else if (pointData.resultDisplay == PredictionTypeEnum.percentage && totalPredictions.home == 0 && totalPredictions.away == 0 && totalPredictions.draw == 0) {
              totalPredictions = TotalPredictions(
                home: _prediction == pointData.homeId ? totalPredictions.home! + 100 : totalPredictions.home,
                away: _prediction == pointData.awayId ? totalPredictions.away! + 100 : totalPredictions.away,
                draw: _prediction == "draw" ? totalPredictions.draw! + 100 : totalPredictions.draw,
              );
            }
          });
        }
      },
    );
  }

  void reInitialize() {
    _visibleResult = false;
    _visibleFirstScore = false;
    _selectedWinning = 3;
    _selectedFirstScore = 3;
    _homeScore = 1;
    _awayScore = 1;
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    _commonProvider = context.commonProvider;
    _firstScoreId = pointData.homeId!;
    _prediction = pointData.homeId!;
    totalPredictions = widget.pointsData.totalPredictions!;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ViewersPredictions(
            pointsData: pointData,
            totalPredictions: totalPredictions,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
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
          Visibility(
            visible: _visibleResult,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  PredictionsCard(
                    predictionText: context.appLocalization.predResult(pointData.matchResultPoints!),
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
          Visibility(
            visible: _visibleFirstScore,
            child: Column(
              children: [
                PredictionsCard(
                  predictionText: context.appLocalization.predFirstScore(pointData.firstScorerPoints!),
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
                            _firstScoreId = index == 0 ? pointData.homeId! : pointData.awayId!;
                          });
                          context
                              .showDialog(
                            bodyText: context.appLocalization.confirmPrediction,
                          )
                              .then((value) async {
                            if (value != null) {
                              // context.authProvider.checkIfUserAuthenticated(
                              //   context,
                              //   callback: () {
                              //     createPrediction();
                              //   },
                              // );
                            } else {
                              setState(() {
                                reInitialize();
                              });
                            }
                          });
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
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
