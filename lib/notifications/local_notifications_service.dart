import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sportk/main.dart';
import 'package:sportk/notifications/notifications_routes_service.dart';
import 'package:sportk/utils/base_extensions.dart';

class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // static late AndroidNotificationChannel androidChannel;

  Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      ),
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (message) {
        if (message.payload != null && message.payload!.isNotEmpty) {
          Map<String, dynamic> data = json.decode(message.payload!);
          NotificationsRouteService().toggle(navigatorKey.currentContext!, data);
        }
      },
    );
  }

  void _createChannels() {}

  String _getSound(String id) {
    switch (id) {
      case 'channel_id_1':
        return 'any_event_in_match';
      case 'channel_id_2':
        return 'end_match_helf';
      case 'channel_id_3':
        return 'goal';
      case 'channel_id_4':
        return 'start_match_half';
      case 'channel_id_5':
        return 'all_other_notification';
      default:
        return 'all_other_notification';
    }
  }

  //for notifications in foreground
  void display(BuildContext context, RemoteMessage message) async {
    try {
      final data = message.notification;
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final pLoad = json.encode(message.data);
      Map<String, dynamic> nData = json.decode(pLoad);
      final channelId = nData['channel_id'] ?? '';
      final sound = _getSound(channelId).replaceAll('wav', '');
      debugPrint("channelId::: $channelId\nsound:: $sound");
      final androidChannel1 = AndroidNotificationChannel(
        channelId, // id
        channelId, // title
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(sound),
      );
      await _flutterLocalNotificationsPlugin.show(
        id,
        data?.title,
        data?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel1.id,
            androidChannel1.name,
            channelDescription: androidChannel1.description,
            importance: androidChannel1.importance,
            playSound: androidChannel1.playSound,
            icon: '@mipmap/ic_launcher',
            color: context.colorScheme.primary,
            sound: androidChannel1.sound,
          ),
          iOS: DarwinNotificationDetails(
            sound: sound,
          ),
        ),
        payload: json.encode(message.data),
      );
    } on Exception catch (e) {
      log("Exception:: $e");
    }
  }
}
