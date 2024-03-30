import 'package:flutter/material.dart';
import 'package:sportk/model/latest_match_team_model.dart';
import 'package:sportk/model/match_model.dart';
import 'package:sportk/model/single_match_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/screens/club/club_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/screens/match_info/widgets/rounded_container.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class TeamCard extends StatefulWidget {
  final Participant team;
  const TeamCard({super.key, required this.team});

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  late Future<List<dynamic>> _futures;
  late FootBallProvider _footBallProvider;
  late Future<LatestMatchTeamModel> _latestMatchFuture;
  late Future<SingleMatchModel> _matchFuture;
  final List<int> _fixters = [];
  final Map<int, String> _latestMatchTeam = {};

  Future<List<dynamic>> _initializeFutures() async {
    _latestMatchFuture = _footBallProvider.fetchLatestMatchTeam(teamId: widget.team.id!);
    final matches = await _latestMatchFuture;
    matches.data!.latest!.map((e) {
      if (matches.data!.latest!.indexOf(e) < 3) {
        _fixters.add(e.id!);
      }
    }).toSet();

    return Future.wait(_fixters.map((fixter) async {
      _matchFuture = _footBallProvider.fetchMatchById(matchId: fixter);
      final singleMatch = await _matchFuture;
      Participant team = Participant();
      Participant against = Participant();
      singleMatch.data!.participants!.map((e) {
        if (e.id == widget.team.id) {
          team = e;
        } else {
          against = e;
        }
      }).toSet();
      filterLatestMatch(team.meta!.winner, against.meta!.winner, _fixters.indexOf(fixter));
    }).toSet());
  }

  filterLatestMatch(bool? team, bool? against, int index) {
    switch ([team, against]) {
      case [false, false]:
      case [null, null]:
        _latestMatchTeam[index] = context.appLocalization.draw;
      case [true, false]:
        _latestMatchTeam[index] = context.appLocalization.winner;
      case [false, true]:
        _latestMatchTeam[index] = context.appLocalization.loser;
    }
  }

  Color getColorCard(String result) {
    if (result == context.appLocalization.draw) {
      return context.colorPalette.yellowFCC;
    } else if (result == context.appLocalization.loser) {
      return context.colorPalette.red000;
    } else {
      return context.colorPalette.greenAD0;
    }
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _futures = _initializeFutures();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNetworkImage(
          widget.team.imagePath!,
          width: 70,
          height: 70,
          onTap: () {
            context.push(ClubScreen(teamId: widget.team.id!));
          },
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 5),
          child: SizedBox(
            height: 40,
            child: Text(
              widget.team.name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: context.colorPalette.white),
            ),
          ),
        ),
        CustomFutureBuilder(
          future: _futures,
          onRetry: () {
            setState(() {
              _futures = _initializeFutures();
            });
          },
          onError: (snapshot) => const SizedBox(height: 25),
          onLoading: () {
            return ShimmerLoading(
              child: SizedBox(
                height: 25,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const LoadingBubble(
                      width: 20,
                      height: 20,
                      margin: EdgeInsetsDirectional.only(end: 5),
                      radius: MyTheme.radiusPrimary,
                    );
                  },
                ),
              ),
            );
          },
          onComplete: (context, snapshot) {
            return SizedBox(
              height: 25,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _latestMatchTeam.length,
                itemBuilder: (context, index) {
                  String key = _latestMatchTeam[index]!;
                  return RoundedContainer(
                    color: getColorCard(key),
                    text: key,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
