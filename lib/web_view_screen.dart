import 'package:flutter/material.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/chat/chat_screen.dart';
import 'package:sportk/screens/match_info/predictions/predictions_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/stretch_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final int matchId;
  const WebViewScreen({
    super.key,
    required this.matchId,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  late CommonProvider _commonProvider;
  int _loadingValue = 0;

  void getMatchPoints() {
    ApiFutureBuilder<MatchPointsModel>().fetch(
      context,
      future: () async {
        final matchPoints = _commonProvider.getMatchPoints(widget.matchId);
        return matchPoints;
      },
      onComplete: (snapshot) {
        if (snapshot.data!.status == 1) {
          context.push(PredictionsScreen(pointsData: snapshot.data!));
        } else {
          context.showSnackBar(context.appLocalization.cantPredictMatch);
        }
      },
    );
  }

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
      ..loadHtmlString('''
    <!DOCTYPE html>
    <html>
    <head>
    <link rel="stylesheet" href="https://widgets.sportmonks.com/css/app.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
    <div id="sportmonks-widget" data-widget="match-centre" data-info="znWv0HaPer7HH0/xNVsk+LvPd6hIs1dKP5hbnsRQ0FnSGdzy3X9gPWO16bQvsy4oyi0EDpuKQ3FSaRlb2ddmyRNauOFOm5au3TsIMarlcFOE46yVsqZnKYCHUn32usAX0sJ9LELqn1K7YmVDBGpjx9QR/Y6qJ0xrLdC0Xij5qE+8NMqFW8z6MSmPMrq2n7edEQCgQeGgpjt+CH6wmLsXUwEqSYOd4psDWxPBVZ5COhm2LA8sIxBwILTJ8z331xgyD5zxEoE9oWKEzGgyiBeFOu45OhFHO9IZOuq2JGeYwX8p1VyHYrcOIV9iT+6otqs9tBEJ7pwpodpHPxaSwewuGgvkV1t9TpX2YJA1p/OiYN4VTrFOo08u4wmrY6rCrGSLzcHqA//h7ANNtK/U+AsUsFePjHqa3457E5NUFhpM2FYqg0Qnt8GgTNMldOwvNBYHPloTP60lm/ZHbYX/6ycASkLb6tJUXyoV8E7CKt05vmJDL9M3nqAJSLLiFXKxUhPAo+brvQwkYPyUDyI2fg+v2vHxhRJRkhhhoxG1D1SEqWvgtCpGkXpY4jHg8/tt7OFBDkXUKKSoAp/61SN7bWZKVV14SxQDILcdrHwpCvLSURBzxf8my3kvWFcaOW5cFde1y46i44HVIDeoemaY9abQXF10v2OKvLtzKp0MO5rPLPI=" data-fixture="${widget.matchId}" data-colors="#032D4B,#6DB9EF,#F2F2F2,#CC0000" data-brand="http://thesportk.com/logo.png" data-tz="America/Maceio" data-lang="${MySharedPreferences.language}" ></div>
    <script type="text/javascript"
                src="https://widgets.sportmonks.com/js/livescore/match-centre.js"></script>
    </body>
    </html>
    ''', baseUrl: "http://thesportk.com");
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    _commonProvider = context.commonProvider;
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
      bottomSheet: Row(
        children: [
          Expanded(
            child: StretchedButton(
              onPressed: () {
                context.push(ChatScreen(matchId: widget.matchId));
              },
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(context.appLocalization.chat),
            ),
          ),
          Expanded(
            child: StretchedButton(
              onPressed: () {
                getMatchPoints();
              },
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(context.appLocalization.predictAndWin),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 50),
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
