import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class ChatBubble extends StatelessWidget {
  final String imageURL, msg;

  const ChatBubble(
    this.msg, {
    super.key,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          imageURL,
          height: 30,
          width: 30,
          shape: BoxShape.circle,
          margin: const EdgeInsetsDirectional.only(end: 5),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsetsDirectional.only(top: 5),
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.zero,
                topEnd: Radius.circular(MyTheme.radiusSecondary),
                bottomStart: Radius.circular(MyTheme.radiusSecondary),
                bottomEnd: Radius.circular(MyTheme.radiusSecondary),
              ),
            ),
            child: Text(
              msg,
              style: TextStyle(
                color: context.colorScheme.onPrimary,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
