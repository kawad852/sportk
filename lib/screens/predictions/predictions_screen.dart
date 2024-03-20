import 'package:flutter/material.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/screens/predictions/widgets/container_card.dart';
import 'package:sportk/screens/predictions/widgets/predictions_card.dart';
import 'package:sportk/screens/predictions/widgets/predictions_container.dart';
import 'package:sportk/screens/predictions/widgets/result_card.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/stretch_button.dart';

class PredictionsScreen extends StatefulWidget {
  final PointsData pointsData;
  const PredictionsScreen({super.key, required this.pointsData});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  int selectedWinning = 0;
  int selectedFirstScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: StretchedButton(
        onPressed: () {},
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(context.appLocalization.confirm),
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
                PredictionsCard(predictionText: context.appLocalization.predTeamWin(10)),
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
                            selectedWinning = index;
                          });
                        },
                        child: PredictionsContainer(
                          index: index,
                          isDraw: index == 1 ? true : false,
                          selectedCard: selectedWinning,
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
              child: Column(
                children: [
                  PredictionsCard(predictionText: context.appLocalization.predResult(50)),
                  const SizedBox(
                    height: 10,
                  ),
                  const ContainerCard(
                    height: 75,
                    child: ResultCard(),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                PredictionsCard(predictionText: context.appLocalization.predFirstScore(10)),
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
                            selectedFirstScore = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: PredictionsContainer(
                            index: index,
                            selectedCard: selectedFirstScore,
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
}
