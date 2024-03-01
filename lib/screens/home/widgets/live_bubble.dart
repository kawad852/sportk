import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/matches/live_matches_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';

class LiveBubble extends StatelessWidget {
  final LiveData liveData;

  const LiveBubble({
    super.key,
    required this.liveData,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
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
  }
}
