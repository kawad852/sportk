import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  //late final WebViewCookieManager cookieManager = WebViewCookieManager();
  //18850171

  String htmlContent = '''
    <!DOCTYPE html>
    <html>
    <head>
    <link rel="stylesheet" href="https://widgets.sportmonks.com/css/app.css">
    </head>
    <body>
    <div id="sportmonks-widget" data-widget="match-centre" data-info="znWv0HaPer7HH0/xNVsk+LvPd6hIs1dKP5hbnsRQ0FnSGdzy3X9gPWO16bQvsy4oyi0EDpuKQ3FSaRlb2ddmyRNauOFOm5au3TsIMarlcFOE46yVsqZnKYCHUn32usAX0sJ9LELqn1K7YmVDBGpjx9QR/Y6qJ0xrLdC0Xij5qE+8NMqFW8z6MSmPMrq2n7edEQCgQeGgpjt+CH6wmLsXUwEqSYOd4psDWxPBVZ5COhm2LA8sIxBwILTJ8z331xgyD5zxEoE9oWKEzGgyiBeFOu45OhFHO9IZOuq2JGeYwX8p1VyHYrcOIV9iT+6otqs9tBEJ7pwpodpHPxaSwewuGgvkV1t9TpX2YJA1p/OiYN4VTrFOo08u4wmrY6rCrGSLzcHqA//h7ANNtK/U+AsUsFePjHqa3457E5NUFhpM2FYqg0Qnt8GgTNMldOwvNBYHPloTP60lm/ZHbYX/6ycASkLb6tJUXyoV8E7CKt05vmJDL9M3nqAJSLLiFXKxUhPAo+brvQwkYPyUDyI2fg+v2vHxhRJRkhhhoxG1D1SEqWvgtCpGkXpY4jHg8/tt7OFBDkXUKKSoAp/61SN7bWZKVV14SxQDILcdrHwpCvLSURBzxf8my3kvWFcaOW5cFde1y46i44HVIDeoemaY9abQXF10v2OKvLtzKp0MO5rPLPI=" data-fixture="18847968" data-colors="#032D4B,#6DB9EF,#F2F2F2,#CC0000" data-brand="http://thesportk.com/logo.png" data-tz="America/Maceio" data-lang="ar" ></div>
    <script type="text/javascript"
                src="https://widgets.sportmonks.com/js/livescore/match-centre.js"></script>
    </body>
    </html>
    ''';

  void _initialize() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
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
      ..loadHtmlString(htmlContent, baseUrl: "https://test.thesportk.com");
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sport Monks Widget'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
// final _cookieManager = CookieManager();
//   const WebViewCookie(
//     name: "test",
//     value: "value",
//     domain: ".posstree.com",
//   ),
// );
// cookies = await _webViewController.runJavascriptReturningResult(
//   'document.cookie',
// );
// print(cookies);