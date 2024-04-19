import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveTracking extends StatefulWidget {
  final String link;
  const LiveTracking({super.key, required this.link});

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  late WebViewController controller;
  int _loadingValue = 0;

  void _updateLoading(int value) {
    setState(() {
      _loadingValue = value;
    });
  }

  void _initialize() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: _updateLoading,
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _loadingValue < 100
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(),
            )
          : null,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: WebViewWidget(
              controller: controller,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: GoogleBanner(
              adSize: AdSize.fullBanner,
            ),
          )
        ],
      ),
    );
  }
}
