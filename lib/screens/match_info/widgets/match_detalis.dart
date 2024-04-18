import 'package:flutter/material.dart';
import 'package:sportk/model/match_detalis_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class MatchDetalis extends StatefulWidget {
  final int matchId;
  const MatchDetalis({super.key, required this.matchId});

  @override
  State<MatchDetalis> createState() => _MatchDetalisState();
}

class _MatchDetalisState extends State<MatchDetalis> with AutomaticKeepAliveClientMixin {
  late FootBallProvider _footBallProvider;
  late Future<MatchDetalisModel> _matchDetalisFuture;
  final Map<String, String> _matchDetalis = {};

  void _initializeFuture() {
    _matchDetalisFuture = _footBallProvider.fetchMatchDetalisById(matchId: widget.matchId);
  }

  void _filterDetalis(MatchDetalisModel detalis) {
    _matchDetalis[context.appLocalization.championship] =
        detalis.data?.league?.name ?? context.appLocalization.unknown;
    _matchDetalis[context.appLocalization.stage] = detalis.data!.roundId != null
        ? "${context.appLocalization.week} ${detalis.data?.round?.name ?? context.appLocalization.unknown}"
        : detalis.data?.stage?.name ?? context.appLocalization.unknown;
    _matchDetalis[context.appLocalization.matchStadium] =
        detalis.data?.venue?.name ?? context.appLocalization.unknown;
    _matchDetalis[context.appLocalization.matchTime] =
        detalis.data!.startingAt!.convertToLocal(context);
    _matchDetalis[context.appLocalization.matchDate] =
        detalis.data!.startingAt!.formatDate(context, pattern: 'EEEE, dd-MM-yyyy');
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
      future: _matchDetalisFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () => ShimmerLoading(
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            return const LoadingBubble(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              radius: MyTheme.radiusSecondary,
            );
          },
        ),
      ),
      onComplete: (context, snapshot) {
        final detalis = snapshot.data!;
        _filterDetalis(detalis);
        return ListView.separated(
          itemCount: _matchDetalis.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            String key = _matchDetalis.keys.elementAt(index);
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: context.colorPalette.grey3F3,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      key,
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(_matchDetalis[key]!),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
