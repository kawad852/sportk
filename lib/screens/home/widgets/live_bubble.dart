import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/web/web_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class LiveBubble extends StatefulWidget {
  final int matchId;
  final void Function() onTracking;

  const LiveBubble({
    super.key,
    required this.matchId, required this.onTracking,
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
      onLoading: () => const ShimmerLoading(
        child: LoadingBubble(
          width: 100,
          height: 25,
          margin: EdgeInsets.only(bottom: 30),
          radius: MyTheme.radiusSecondary,
          )
          ,),
      onError: (snapshot) => const SizedBox.shrink(),
      onComplete: (context, snapshot) {
        if (snapshot.data!.data != null) {
          return ZoomIn(
            child: Container(
              width: 160,
              height: 25,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: context.colorPalette.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      context.push(WebScreen(url: snapshot.data!.data!.link!));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/point.json"),
                        // const SizedBox(
                        //   width: 3,
                        // ),
                        Text(
                          context.appLocalization.live,
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 6,),
                   GestureDetector(
                    onTap: widget.onTracking,
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomSvg(
                            MyIcons.liveTracking,
                            fixedColor: true,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            context.appLocalization.liveTracking,
                            style:
                                TextStyle(color: context.colorPalette.blueD4B),
                          )
                        ],
                      ),
                   ),
                ],
              ),
            ),
          );
        }
        return ZoomIn(
          child: Container(
            width: 100,
            height: 25,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: context.colorPalette.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: GestureDetector(
                onTap: widget.onTracking,
                child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomSvg(
                            MyIcons.liveTracking,
                            fixedColor: true,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            context.appLocalization.liveTracking,
                            style:
                                TextStyle(color: context.colorPalette.blueD4B),
                          )
                        ],
                      ) ,
              ),
          ),
        );
      },
    );
  }
}
