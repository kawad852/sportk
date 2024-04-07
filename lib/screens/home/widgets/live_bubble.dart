import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/web/web_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class LiveBubble extends StatefulWidget {
  final int matchId;

  const LiveBubble({
    super.key,
    required this.matchId,
  });

  @override
  State<LiveBubble> createState() => _LiveBubbleState();
}

class _LiveBubbleState extends State<LiveBubble> {
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
      onLoading: () => const SizedBox.shrink(),
      onError: (snapshot) => const SizedBox.shrink(),
      onComplete: (context, snapshot) {
        if (snapshot.data!.data != null) {
          return ZoomIn(
            child: GestureDetector(
              onTap: () {
                context.push(WebScreen(url: snapshot.data!.data!.link!));
              },
              child: Container(
                width: 64,
                height: 25,
                decoration: BoxDecoration(
                  color: context.colorPalette.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorPalette.red000,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      context.appLocalization.live,
                      style: TextStyle(color: context.colorPalette.blueD4B),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
