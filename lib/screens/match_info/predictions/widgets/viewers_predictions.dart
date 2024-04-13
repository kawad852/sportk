import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/screens/match_info/predictions/widgets/prediction_text.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';

class ViewersPredictions extends StatefulWidget {
  final PointsData pointsData;
  final TotalPredictions totalPredictions;
  const ViewersPredictions({
    super.key,
    required this.pointsData,
    required this.totalPredictions,
  });

  @override
  State<ViewersPredictions> createState() => _ViewersPredictionsState();
}

class _ViewersPredictionsState extends State<ViewersPredictions> {
  PointsData get pointData => widget.pointsData;
  TotalPredictions get totalPredictions => widget.totalPredictions;

  bool get _isPercentage => pointData.resultDisplay == PredictionTypeEnum.percentage;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        width: double.infinity,
        height: 71,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
          color: context.colorPalette.viewersPredictions,
        ),
        child: Column(
          children: [
            Text(
              context.appLocalization.viewersPredictions,
              style: TextStyle(
                color: context.colorPalette.white,
              ),
            ),
            totalPredictions.home == 0 && totalPredictions.draw == 0 && totalPredictions.away == 0
                ? PredictionText(
                    text: context.appLocalization.makePrediction,
                    textAlign: TextAlign.center,
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PredictionText(text: pointData.homeName!),
                          const SizedBox(
                            width: 10,
                          ),
                          PredictionText(
                            text: pointData.awayName!,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 5,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: totalPredictions.home!,
                              child: Container(
                                color: context.colorPalette.green54C,
                              ),
                            ),
                            Expanded(
                              flex: totalPredictions.draw!,
                              child: Container(
                                color: context.colorPalette.yellowFDD,
                              ),
                            ),
                            Expanded(
                              flex: totalPredictions.away!,
                              child: Container(
                                color: context.colorPalette.green54C,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          PredictionText(
                            flex: totalPredictions.home!,
                            text: _isPercentage
                                ? "${totalPredictions.home}%"
                                : totalPredictions.home.toString(),
                            textAlign: TextAlign.center,
                          ),
                          PredictionText(
                            flex: totalPredictions.draw!,
                            text: totalPredictions.draw == 0
                                ? ""
                                : _isPercentage
                                    ? "${totalPredictions.draw}%"
                                    : totalPredictions.draw.toString(),
                            textAlign: TextAlign.center,
                          ),
                          PredictionText(
                            flex: totalPredictions.away!,
                            text: _isPercentage
                                ? "${totalPredictions.away}%"
                                : totalPredictions.away.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
