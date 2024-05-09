import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sportk/alerts/loading/app_over_loader.dart';
import 'package:sportk/main.dart';
import 'package:sportk/notifications/notifications_routes_service.dart';
import 'package:sportk/utils/app_constants.dart';

class DeepLinkingService {
  static StreamSubscription<Map>? streamSubscription;
  static StreamController<String> controllerData = StreamController<String>();
  static StreamController<String> controllerInitSession = StreamController<String>();

  static void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.listSession().listen(
      (data) async {
        controllerData.sink.add((data.toString()));
        if (data.containsKey('+clicked_branch_link') && data['+clicked_branch_link'] == true) {
          NotificationsRouteService().toggle(
            navigatorKey.currentContext!,
            {
              'id': data['id'],
              'type': data['type'],
            },
          );
        }
      },
      onError: (error) {
        debugPrint('DeepLinkingError: ${error.toString()}');
      },
    );
  }

  static Future<String?> generateLink(
    BuildContext context, {
    required BranchUniversalObject buo,
    required BranchLinkProperties lp,
  }) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      return response.result;
    } else {
      return null;
    }
  }

  static void share(
    BuildContext context, {
    String? id,
    required String type,
    required String title,
    required String description,
    String? imageURL,
  }) async {
    AppOverlayLoader.fakeLoading();
    final buo = BranchUniversalObject(
      canonicalIdentifier: kBranchIdentifier,
      canonicalUrl: kBranchWebURL,
      title: title,
      contentDescription: description,
      imageUrl: imageURL??'',
      expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch,
    );

    final lp = BranchLinkProperties()
      ..addControlParam('id', id)
      ..addControlParam('type', type);

    final link = await generateLink(context, buo: buo, lp: lp);

    Share.share(link!);
  }
}
