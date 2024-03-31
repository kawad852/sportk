import 'package:flutter/material.dart';
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
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void initState() {
    super.initState();
    _initialize();
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
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 50),
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
