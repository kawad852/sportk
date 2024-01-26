import 'package:flutter/material.dart';
import 'package:sportk/model/competition_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LeagueTile extends StatefulWidget {
  final String competitionId;
  final Widget? trailing;

  const LeagueTile({
    super.key,
    this.trailing,
    required this.competitionId,
  });

  @override
  State<LeagueTile> createState() => _LeagueTileState();
}

class _LeagueTileState extends State<LeagueTile> {
  late Future<CompetitionModel> _competitionFuture;
  late FootBallProvider _footBallProvider;

  void _initializeCompetition() {
    _competitionFuture = _footBallProvider.fetchCompetitions(uuid: widget.competitionId);
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeCompetition();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _competitionFuture,
      onRetry: () {},
      onError: (snapshot) => const SizedBox.shrink(),
      onLoading: () {
        return const ShimmerLoading(
          child: LoadingBubble(
            height: 50,
          ),
        );
      },
      onComplete: (context, snapshot) {
        final competition = snapshot.data!;
        final result = competition.results!.first;
        return ListTile(
          onTap: () {
            // context.push(const LeagueScreen());
          },
          dense: true,
          tileColor: context.colorPalette.grey2F2,
          leading: CustomNetworkImage(
            result.logo!,
            radius: 0,
            width: 25,
            height: 25,
          ),
          title: Text(
            result.name!,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: widget.trailing,
        );
      },
    );
  }
}
