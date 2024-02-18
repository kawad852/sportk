import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SportMonksWidget extends StatefulWidget {
  const SportMonksWidget({super.key});

  @override
  State<SportMonksWidget> createState() => _SportMonksWidgetState();
}

class _SportMonksWidgetState extends State<SportMonksWidget> {
  late WebViewController controller;

  String htmlContent = '''
    <!DOCTYPE html>
    <html>
    <head>
    <link rel="stylesheet" href="https://widgets.sportmonks.com/css/app.css">
    </head>
    <body>
    <div id="sportmonks-widget" data-widget="match-centre" data-info="d3SsOc6u9GrLIJZYys+ePudJ1mGrVTF8tJcIO8xTZPBOcT0onbEXbQrjz/T+DwtiyuISruCto3MxniUEoixm/m0hw/Al1u6xa6kTl9t0+ph+S34pwTvfSuf/D/iV8JXMc56LCjisajuqgChRp0K08StEsOgUe+HSxs3gQXX/g9bpvSue3+12IIcnMrDTWviN34tb/JvoK+2sSI4nTXbHv8dzfMKVn9JBWsaZSQZpZdJ3iALHOV0BgWkzVEIc+0Hv8S7VtMBZwS9Nie2S5YUu/VFVEB6mbK/KG3kJXjJ2/UT+ZrpoQJBzyIssugIUZ30jLQe2jACTTxcwsC/l/usALZ1wCJGKguHJ+kag1wcwr8xSona7QaDCY70W1NCM98q52vXCzyBN8JgeUctLh6oPYbVbM2UisUP8eorKJiL+b6jNHMp4ZFTW2ENwCQioXIyKc+rv4e180hiVb5OmjKam4wh+xliCfSEX/lojHNt1g3ViuMIL67Y9Axatg28RUR8UQStZqFvxlhGTeKkcKyumfNtuemhy6h3kP1yiqT6GT82IPPmYvYWESaXg4BhmSlj5KjV32ZAJR4aEutTxaX8F1V5BST9Ti51YYD1OFld534h4bdfX75H0KgJRHmN7PrjgAE1aF8+95Cxu5j1Vk/wfe++RDp4fZ7FT1yWjhuWphOc=" data-fixture="18841659" data-colors="#010028,#1893C1,#D0D0D9,#343353" ></div>
    <script type="text/javascript" src="https://widgets.sportmonks.com/js/livescore/match-centre.js"></script>
    </body>
    </html>
    ''';

  void _initialize() {
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
      ..loadRequest(Uri.dataFromString(
        htmlContent,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ));
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
        title: Text('Sport Monks Widget'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
