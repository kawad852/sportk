import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class LeagueBubble extends StatelessWidget {
  const LeagueBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      child: Column(
        children: [
          CustomNetworkImage(
            kFakeImage,
            height: 100,
          ),
          Text(
            "Real MadridReal MadridReal Madrid",
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
