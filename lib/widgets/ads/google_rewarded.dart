import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sportk/utils/base_extensions.dart';

class GoogleRewarded extends StatefulWidget {
  final Widget child;
  final int points;

  const GoogleRewarded({
    super.key,
    required this.child,
    required this.points,
  });

  @override
  State<GoogleRewarded> createState() => _GoogleRewardedState();
}

class _GoogleRewardedState extends State<GoogleRewarded> {
  RewardedAd? _rewardedAd;

  String get _iosUnitId => kDebugMode ? '' : '';
  String get _androidUnitId => kDebugMode ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-4829894010518123/7748299329';

  void showAd(BuildContext context) {
    final authProvider = context.authProvider;
    _rewardedAd?.show(
      onUserEarnedReward: (ad, rewardItem) {
        setState(() {
          _rewardedAd = null;
        });
        authProvider.user.points = authProvider.user.points! + widget.points;
        authProvider.updateProfile(
          context,
          {
            'points': authProvider.user.points,
          },
          update: false,
        );
        authProvider.updateUser(context);
      },
    );
  }

  /// Loads a banner ad.
  void _loadAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid ? _androidUnitId : _iosUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_rewardedAd == null) {
      return const SizedBox(height: 20);
    }
    return GestureDetector(
      onTap: () {
        showAd(context);
      },
      child: widget.child,
    );
  }
}
