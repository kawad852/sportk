import 'package:flutter/material.dart';
import 'package:sportk/helper/lanucher_helper.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/stretch_button.dart';

class NewsDetailsCard extends StatelessWidget {
  final NewData newData;
  final String? source;

  const NewsDetailsCard({
    super.key,
    required this.newData,
    this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          context.image(newData.image!),
          radius: 10,
          width: double.infinity,
          height: 200,
          alignment: AlignmentDirectional.bottomStart,
          child: source != null
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(start: 6),
                  child: Chip(
                    backgroundColor: context.colorPalette.red000,
                    labelStyle: TextStyle(
                      color: context.colorPalette.white,
                    ),
                    side: BorderSide.none,
                    label: Text(
                      source!,
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              newData.publicationTime!.formatDate(context),
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(width: 6),
            const CustomSvg(MyIcons.clock),
          ],
        ),
        Text(
          newData.title!,
          style: TextStyle(
            color: context.colorPalette.blueD4B,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
          child: Text(
            newData.content!,
          ),
        ),
        if (newData.link != null)
          StretchedButton(
            onPressed: () {
              LauncherHelper.lunch(context, newData.link!);
            },
            margin: const EdgeInsetsDirectional.only(bottom: 15),
            child: Text(
              context.appLocalization.newReadSource,
              style: TextStyle(color: context.colorPalette.white),
            ),
          ),
      ],
    );
  }
}
