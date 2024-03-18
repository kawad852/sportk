import 'package:flutter/material.dart';
import 'package:sportk/model/notificaion_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class NotificationBubble extends StatelessWidget {
  final NotificationData notification;

  const NotificationBubble({
    super.key,
    required this.notification,
  });

  Widget _buildText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorPalette.grey9F9,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomNetworkImage(
            '',
            height: 40,
            width: 40,
            margin: EdgeInsetsDirectional.only(end: 10),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(notification.title!),
                _buildText(notification.content!),
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    '22.3.4',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
