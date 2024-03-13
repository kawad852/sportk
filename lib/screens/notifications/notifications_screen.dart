import 'package:flutter/material.dart';
import 'package:sportk/screens/notifications/widgets/notification_bubble.dart';
import 'package:sportk/utils/base_extensions.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.notifications),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return const NotificationBubble();
        },
      ),
    );
  }
}
