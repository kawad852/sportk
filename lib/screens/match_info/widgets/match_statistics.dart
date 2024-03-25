import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class MatchStatistics extends StatefulWidget {
  final int matchId;
  const MatchStatistics({super.key, required this.matchId});

  @override
  State<MatchStatistics> createState() => _MatchStatisticsState();
}

class _MatchStatisticsState extends State<MatchStatistics> {
  late FootBallProvider _footBallProvider;
  late Future<SingleMatchModel> _matchFuture;
  Map<String, int> homeStatistics = {};
  Map<String, int> awayStatistics = {};


  void _initializeFuture() {
    _matchFuture = _footBallProvider.fetchMatchById(matchId: widget.matchId);
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
      future: _matchFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final match = snapshot.data!;
        match.data!.statistics!.map((e) {
          
        },).toSet();
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 87,
                margin: const EdgeInsetsDirectional.only(top: 10),
                decoration: BoxDecoration(
                  color: context.colorPalette.grey3F3,
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "50%",
                      style: TextStyle(
                        color: context.colorPalette.progressGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 37.0,
                      animation: true,
                      animationDuration: 1000,
                      lineWidth: 3.0,
                      percent: 0.5,
                      center: Text(context.appLocalization.possession),
                      backgroundColor: context.colorPalette.progressRed,
                      progressColor: context.colorPalette.progressGreen,
                    ),
                    Text(
                      "50%",
                      style: TextStyle(
                        color: context.colorPalette.progressRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: context.colorPalette.grey3F3,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "7",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "اجمالي التسديدات",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "4",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LinearPercentIndicator(
                              barRadius: const Radius.circular(MyTheme.radiusSecondary),
                              width: 145.0,
                              lineHeight: 8.0,
                              percent: 0,
                              backgroundColor: context.colorPalette.greyD9D,
                              progressColor: context.colorPalette.progressGreen,
                            ),
                            LinearPercentIndicator(
                              barRadius: const Radius.circular(MyTheme.radiusSecondary),
                              width: 145.0,
                              lineHeight: 8.0,
                              percent: 0.5,
                              isRTL: true,
                              backgroundColor: context.colorPalette.greyD9D,
                              progressColor: context.colorPalette.progressRed,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
