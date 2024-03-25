import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sportk/alerts/loading/app_over_loader.dart';

class DeepLinkingService {
  static BranchContentMetaData metadata = BranchContentMetaData();
  static BranchLinkProperties lp = BranchLinkProperties();
  static late BranchUniversalObject buo;
  static late BranchEvent eventStandard;
  static late BranchEvent eventCustom;

  static StreamSubscription<Map>? streamSubscription;
  static StreamController<String> controllerData = StreamController<String>();
  static StreamController<String> controllerInitSession = StreamController<String>();

  static void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.listSession().listen((data) async {
      print('listenDynamicLinks - DeepLink Data: $data');
      controllerData.sink.add((data.toString()));

      /*
      if (data.containsKey('+is_first_session') &&
          data['+is_first_session'] == true) {
        // wait 3 seconds to obtain installation data
        await Future.delayed(const Duration(seconds: 3));
        Map<dynamic, dynamic> params =
            await FlutterBranchSdk.getFirstReferringParams();
        controllerData.sink.add(params.toString());
        return;
      }
       */

      if (data.containsKey('+clicked_branch_link') && data['+clicked_branch_link'] == true) {
        print('------------------------------------Link clicked----------------------------------------------');
        print('Custom string: ${data['custom_string']}');
        print('Custom string: ${data['id']}');
        print('Custom number: ${data['custom_number']}');
        print('Custom bool: ${data['custom_bool']}');
        print('Custom list number: ${data['custom_list_number']}');
        print('------------------------------------------------------------------------------------------------');
        print('Link clicked: Custom string - ${data['custom_string']}');
        if (data['id'] != null) {
          print("lalalalalalala");
          // rootNavigatorKey.currentContext!.khaled(ProductDetailsScreen(id: data['id']));
        }
      }
    }, onError: (error) {
      print('listSesseion error: ${error.toString()}');
    });
  }

  static void initDeepLinkData(String productId) {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('custom_string', 'abcd')
      ..addCustomMetadata('custom_number', 12345)
      ..addCustomMetadata('custom_bool', true)
      ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
      ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
      //--optional Custom Metadata
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(street: 'street', city: 'city', region: 'ES', country: 'Brazil', postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);

    buo = BranchUniversalObject(
      canonicalIdentifier: 'myapp/branch',
      canonicalUrl: 'https://flutter.dev',
      title: 'Flutter Branch Plugin',
      imageUrl: 'imageURL',
      contentDescription: 'Flutter Branch Description',
      /*
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('custom_string', 'abc')
          ..addCustomMetadata('custom_number', 12345)
          ..addCustomMetadata('custom_bool', true)
          ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
          ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
         */
      contentMetadata: metadata,
      keywords: ['Plugin', 'Branch', 'Flutter'],
      publiclyIndex: true,
      locallyIndex: true,
      expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch,
    );

    lp = BranchLinkProperties(channel: 'facebook', feature: 'sharing', stage: 'new share', campaign: 'campaign', tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('type', 'product')
      ..addControlParam('id', productId);

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..alias = 'StandardEventAlias'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData('Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData('Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..alias = 'CustomEventAlias'
      ..addCustomData('Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData('Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  static Future<String?> generateLink(BuildContext context) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      print("link::: ${response.result}");
      return response.result;
    } else {
      print("error generating link");
      return null;
    }
  }

  void shareLink(BuildContext context, String id) async {
    AppOverlayLoader.fakeLoading();
    final link = await generateLink(context);
    DeepLinkingService.initDeepLinkData(id);
    Share.share(link!);
  }
}
