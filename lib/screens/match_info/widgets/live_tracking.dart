import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sportk/screens/match_info/widgets/match_live.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveTracking extends StatefulWidget {
  final int matchId;
  final String link;
  const LiveTracking({super.key, required this.link, required this.matchId});

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking>
    with AutomaticKeepAliveClientMixin {
  late WebViewController controller;

  bool showPage = false;

  void _initialize() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            Future.delayed(const Duration(seconds: 2)).then(
              (value) => setState(() {
                showPage = true;
              }),
            );
          },
          onWebResourceError: (WebResourceError error) {
            print('myError::: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString('''
    <!DOCTYPE html>
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
      <embed type="text/html" src="${widget.link}" width="100%" height="250">
    </body>
    </html>
    ''', baseUrl: "https://eascore.io/");
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: !showPage
          ? Container(
              width: double.infinity,
              height: 280,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                color: const Color(0xFFD9D9D9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    MyImages.logo,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  SpinKitCircle(color: context.colorPalette.white),
                ],
              ),
            )
          : Column(
              children: [
                MatchLive(matchId: widget.matchId),
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: WebViewWidget(
                    controller: controller,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: GoogleBanner(
                    adSize: AdSize.fullBanner,
                  ),
                )
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
