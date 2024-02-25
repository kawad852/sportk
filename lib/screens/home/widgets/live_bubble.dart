import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/show_live_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class LiveBubble extends StatefulWidget {
  final int leagueId;

  const LiveBubble({
    super.key,
    required this.leagueId,
  });

  @override
  State<LiveBubble> createState() => _LiveBubbleState();
}

class _LiveBubbleState extends State<LiveBubble> {
  late Future<ShowLiveModel> _future;

  void _initializeFuture() {
    _future = ApiService<ShowLiveModel>().build(
      weCanUrl: '${ApiUrl.showLive}/${widget.leagueId}',
      isPublic: true,
      apiType: ApiType.get,
      builder: ShowLiveModel.fromJson,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _future,
      onRetry: () {},
      onLoading: () => const SizedBox.shrink(),
      onError: (snapshot) => const SizedBox.shrink(),
      onComplete: (context, snapshot) {
        return FadeIn(
          child: Transform.rotate(
            angle: -pi / 2,
            child: Container(
              height: 20,
              width: 40,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: context.colorPalette.red000,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              alignment: Alignment.center,
              child: Text(
                context.appLocalization.live,
                style: context.textTheme.labelSmall!.copyWith(
                  color: context.colorPalette.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
