import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleBanner extends StatefulWidget {
  final Widget? onLoading;
  final AdSize adSize;
  const GoogleBanner({
    super.key,
    this.onLoading,
    this.adSize = AdSize.fullBanner,
  });

  @override
  State<GoogleBanner> createState() => _GoogleBannerState();
}

class _GoogleBannerState extends State<GoogleBanner> {
  BannerAd? _bannerAd;
  bool _loading = true;

  String get _iosUnitId => kDebugMode ? 'ca-app-pub-3940256099942544/2934735716' : 'ca-app-pub-8605854106910601/7566320514';
  String get _androidUnitId => kDebugMode ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-8605854106910601/8827431292';

  AdSize get _adSize => widget.adSize;

  void _toggleLoading(bool status) {
    setState(() {
      _loading = status;
    });
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: _adSize,
      adUnitId: Platform.isAndroid ? _androidUnitId : _iosUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            _toggleLoading(false);
            ad.dispose();
            return;
          }
          setState(() {
            _toggleLoading(false);
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _toggleLoading(false);
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return widget.onLoading ?? const SizedBox.shrink();
    } else if (!_loading && _bannerAd == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: _adSize.width.toDouble(),
      height: _adSize.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
