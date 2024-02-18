import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleRewarded extends StatefulWidget {
  const GoogleRewarded({super.key});

  @override
  State<GoogleRewarded> createState() => _GoogleRewardedState();
}

class _GoogleRewardedState extends State<GoogleRewarded> {
  RewardedAd? _rewardedAd;

  String get _iosUnitId => kDebugMode ? '' : '';
  String get _androidUnitId => kDebugMode ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-4829894010518123/7748299329';

  void showAd() {
    _rewardedAd?.show(
      onUserEarnedReward: (ad, rewardItem) {},
    );
  }

  /// Loads a banner ad.
  void _loadAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid ? _androidUnitId : _iosUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
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
    return TextButton(
      onPressed: () {
        showAd();
      },
      child: Text("Show add"),
    );
  }
}
