import 'package:flutter/material.dart';
import 'package:sportk/model/league_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueCard extends StatefulWidget {
  final int index;
  final int selectIndex;
  final int leagueId;
  const LeagueCard({super.key, required this.index, required this.selectIndex, required this.leagueId});

  @override
  State<LeagueCard> createState() => _LeagueCardState();
}

class _LeagueCardState extends State<LeagueCard> {
  late FootBallProvider _footBallProvider;
  late Future<LeagueModel> _leagueFuture;
  void _initializeFuture() {
    _leagueFuture = _footBallProvider.fetchLeague(leagueId: widget.leagueId);
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
      future: _leagueFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return const ShimmerLoading(
          child: LoadingBubble(
            width: 70,
            height: 30,
            margin: EdgeInsetsDirectional.only(start: 5, end: 5),
            radius: MyTheme.radiusPrimary,
          ),
        );
      },
      onError: (snapshot) {
        return const SizedBox.shrink();
      },
      onComplete: (context, snapshot) {
        final league = snapshot.data!;
        return Container(
          height: 30,
          margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
          decoration: BoxDecoration(
            color: widget.selectIndex == widget.index ? context.colorPalette.blueABB : context.colorPalette.blue4F0,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
            child: Row(
              children: [
                CustomNetworkImage(
                  league.data!.imagePath!,
                  width: 20,
                  height: 20,
                  radius: 0,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  league.data!.name!,
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
