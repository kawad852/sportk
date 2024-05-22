import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/widgets/phase_card.dart';
import 'package:sportk/screens/match_info/widgets/match_live.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/match_card.dart';
import 'package:sportk/widgets/no_results.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class HeadToHead extends StatefulWidget {
  final int matchId;
  final int fisrtTeamId;
  final int secondTeamId;

  const HeadToHead({super.key, required this.fisrtTeamId, required this.secondTeamId, required this.matchId});

  @override
  State<HeadToHead> createState() => _HeadToHeadState();
}

class _HeadToHeadState extends State<HeadToHead> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<MatchModel> _headToHeadFuture;

  void _initializeFuture() {
    _headToHeadFuture = _footBallProvider.fetchHeadToHeadMatches(
      firstTeamId: widget.fisrtTeamId,
      secondTeamId: widget.secondTeamId,
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
    super.build(context);
    return CustomFutureBuilder(
      future: _headToHeadFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () => ShimmerLoading(
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) {
            return const Column(
              children: [
                LoadingBubble(
                  width: double.infinity,
                  height: 35,
                  margin: EdgeInsetsDirectional.only(bottom: 10),
                  radius: MyTheme.radiusPrimary,
                ),
                LoadingBubble(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsetsDirectional.only(bottom: 10),
                  radius: MyTheme.radiusPrimary,
                ),
              ],
            );
          },
        ),
      ),
      onComplete: (context, snapshot) {
        final matches = snapshot.data!;
        return matches.data!.isEmpty
            ? NoResults(
                header: const Icon(FontAwesomeIcons.baseball),
                title: context.appLocalization.noInfoConfrontations,
              )
            : SingleChildScrollView(
              child: Column(
                children: [
                  MatchLive(matchId: widget.matchId),
                  ListView.builder(
                      itemCount: matches.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemBuilder: (context, index) {
                        final elemant = matches.data![index];
                        return Column(
                          children: [
                            PhaseCard(
                              teamId: widget.fisrtTeamId,
                              stageId: elemant.stageId!,
                              leagueId: elemant.leagueId!,
                              roundId: elemant.roundId,
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () async {
                                await UiHelper.navigateToMatchInfo(
                                  context,
                                  matchId: elemant.id!,
                                  leagueId: elemant.leagueId!,
                                  subType: elemant.league!.subType!,
                                  afterNavigate: () {},
                                );
                              },
                              child: MatchCard(element: elemant),
                            )
                          ],
                        );
                      },
                    ),
                ],
              ),
            );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
