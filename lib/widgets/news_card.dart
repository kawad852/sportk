import 'package:flutter/material.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/screens/news/news_detalis_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class NewsCard extends StatelessWidget {
  final bool? isMessage;
  final NewData newData;

  const NewsCard({
    super.key,
    this.isMessage = false,
    required this.newData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(15),
      ),
      constraints: const BoxConstraints(minWidth: 280),
      margin: const EdgeInsetsDirectional.all(8.0),
      height: 260.0,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: CustomNetworkImage(
              context.image(newData.image!),
              onTap: () {
                context.push(const NewsDetalisScreen());
              },
              radius: 0,
              height: 153,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Column(
              children: [
                Text(
                  newData.title!,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CustomNetworkImage(
                      context.image(newData.image!),
                      radius: 5,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${newData.source} - ${newData.publicationTime!.formatDate(context)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.colorPalette.blueD4B,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Container(
                color: context.colorPalette.grey9E9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const CustomSvg(
                            MyIcons.heart,
                            width: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "1.3k",
                          style: TextStyle(color: context.colorPalette.red000),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const CustomSvg(
                        MyIcons.download,
                        width: 25,
                      ),
                    ),
                    if (isMessage == true)
                      IconButton(
                        onPressed: () {},
                        icon: const CustomSvg(
                          MyIcons.message,
                          width: 25,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
