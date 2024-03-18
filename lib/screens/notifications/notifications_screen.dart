import 'package:flutter/material.dart';
import 'package:sportk/model/notificaion_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/notifications/widgets/notification_bubble.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<NotificationModel> _fetchNotifications(int pageKey) {
    final snapshot = ApiService<NotificationModel>().build(
      weCanUrl: '${ApiUrl.notifications}?page=$pageKey',
      isPublic: false,
      apiType: ApiType.get,
      builder: NotificationModel.fromJson,
    );
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.notifications),
      ),
      body: VexPaginator(
        query: (pageKey) async => _fetchNotifications(pageKey),
        onFetching: (snapshot) async => snapshot.data!,
        pageSize: 10,
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final notification = snapshot.docs[index] as NotificationData;
              return NotificationBubble(
                notification: notification,
              );
            },
          );
        },
      ),
    );
  }
}
