import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/shared_pref.dart';

class GoogleInterstitial extends StatefulWidget {
  final Widget child;

  const GoogleInterstitial({
    super.key,
    required this.child,
  });

  @override
  State<GoogleInterstitial> createState() => _GoogleInterstitialState();
}

class _GoogleInterstitialState extends State<GoogleInterstitial> {
  InterstitialAd? _interstitialAd;

  bool _failed = false;

  String get _iosUnitId => kDebugMode ? 'ca-app-pub-3940256099942544/4411468910' : 'ca-app-pub-8605854106910601/9757369580';
  String get _androidUnitId => kDebugMode ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-8605854106910601/6827953917';

  void showAd(BuildContext context) {
    _interstitialAd?.show();
  }

  /// Loads a banner ad.
  void _loadAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid ? _androidUnitId : _iosUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (value) {},
          );
          debugPrint('$ad loaded.');
          setState(() {
            _interstitialAd = ad;
            MySharedPreferences.showAd = false;
            _interstitialAd?.show();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          setState(() {
            _failed = true;
          });
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (MySharedPreferences.showAd) {
      _loadAd();
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_interstitialAd == null && !_failed && MySharedPreferences.showAd) {
      return Material(
        color: context.colorScheme.background,
        child: context.loaders.circular(),
      );
    }
    return widget.child;
  }
}
