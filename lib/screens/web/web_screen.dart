import 'package:flutter/material.dart';
import 'package:sportk/widgets/ads/google_banner.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  final String url;

  const WebScreen({
    super.key,
    required this.url,
  });

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
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
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: _updateLoading,
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
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
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _loadingValue < 100
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(),
            )
          : null,
      bottomNavigationBar: const BottomAppBar(
        child: GoogleBanner(),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
