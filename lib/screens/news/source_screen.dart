import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SourceScreen extends StatefulWidget {
  final String url;

  const SourceScreen({
    super.key,
    required this.url,
  });

  @override
  State<SourceScreen> createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
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
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
