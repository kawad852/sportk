import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class MatchLive extends StatefulWidget {
  final int matchId;
  final EdgeInsetsGeometry? margin;
  const MatchLive({super.key, required this.matchId, this.margin});

  @override
  State<MatchLive> createState() => _MatchLiveState();
}

class _MatchLiveState extends State<MatchLive> {
  late Future<LivesMatchesModel> _future;

  void _fetchLive() {
    _future = ApiService<LivesMatchesModel>().build(
      weCanUrl: '${ApiUrl.showLive}/${widget.matchId}',
      isPublic: true,
      apiType: ApiType.get,
      builder: LivesMatchesModel.fromJson,
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchLive();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _future,
      onRetry: () {},
      onError: (snapshot) => const SizedBox.shrink(),
      onLoading: () =>  ShimmerLoading(
          child: LoadingBubble(
        width: double.infinity,
        height: 30,
        margin: widget.margin??const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        radius: MyTheme.radiusSecondary,
      )),
      onComplete: (context, snapshot) {
        if (snapshot.data!.data != null) {
          return ZoomIn(
            child: Container(
              width: double.infinity,
              height: 30,
              margin:widget.margin?? const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                color: MyTheme.isLightTheme(context)
                    ? context.colorPalette.red100.withOpacity(0.3)
                    : context.colorPalette.red100.withOpacity(0.5),
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.appLocalization.watchMatchLive),
                  Text(
                    context.appLocalization.topLive,
                    style: TextStyle(color: context.colorPalette.red100),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
