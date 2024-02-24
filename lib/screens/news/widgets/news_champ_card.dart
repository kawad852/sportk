import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class NewsChampCard extends StatelessWidget {
  const NewsChampCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: context.colorPalette.grey9E9,
        borderRadius: BorderRadius.circular(MyTheme.radiusPrimary),
      ),
      alignment: Alignment.center,
      child: const CustomNetworkImage(
        kFakeImage,
        radius: 0,
        width: 48,
        height: 30,
      ),
    );
  }
}
