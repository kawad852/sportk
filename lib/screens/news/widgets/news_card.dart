import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/screens/news/widgets/like_button.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class NewsCard extends StatefulWidget {
  final NewData newData;

  const NewsCard({
    super.key,
    required this.newData,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late CommonProvider _commonProvider;

  NewData get _newData => widget.newData;

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
  }

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
              _newData.image!,
              onTap: () {
                context.push(NewsDetailsScreen(newId: _newData.id!));
              },
              radius: 0,
              height: 153,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _newData.title!,
                  maxLines: 2,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    if (_newData.source != null) ...[
                      CustomNetworkImage(
                        _newData.sourceImage!,
                        radius: 5,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                    Text(
                      "${_newData.source != null ? '${_newData.source} - ' : ''}${_newData.publicationTime!.formatDate(context)}",
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
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          children: [
                            ZoomIn(
                              child: LikeButton(
                                isLike: _newData.isLiked!,
                                onPressed: () {
                                  setState(() {
                                    _newData.isLiked = !_newData.isLiked!;
                                    if (_newData.isLiked!) {
                                      _newData.numberOfLikes = _newData.numberOfLikes! + 1;
                                      _commonProvider.like(_newData.id!, true, isComment: false);
                                    } else {
                                      _newData.numberOfLikes = _newData.numberOfLikes! - 1;
                                      _commonProvider.removeLike(_newData.id!, false);
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ZoomIn(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 350),
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  return ScaleTransition(scale: animation, child: child);
                                },
                                child: Text(
                                  "${_newData.numberOfLikes}",
                                  key: ValueKey<int>(_newData.numberOfLikes!),
                                  style: TextStyle(color: context.colorPalette.red000),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const CustomSvg(
                        MyIcons.download,
                        width: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        UiHelper.showCommentsSheet(context, _newData.id!);
                      },
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
