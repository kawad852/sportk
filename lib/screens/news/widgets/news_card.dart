import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/deep_linking_service.dart';
import 'package:sportk/utils/enums.dart';
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

  void _toggleLike(int? likeType, bool fromLike) {
    if (likeType == LikeType.like) {
      _commonProvider.like(_newData.id!, likeType!, isComment: true);
      _newData.numberOfLikes = _newData.numberOfLikes! + 1;
    }
    if (likeType == LikeType.disLike) {
      _commonProvider.like(_newData.id!, likeType!, isComment: true);
      if (_newData.likeType == LikeType.like) {
        _newData.numberOfLikes = _newData.numberOfLikes! - 1;
      }
    }
    if (likeType == null) {
      _commonProvider.removeLike(_newData.id!, true);
      if (fromLike) {
        _newData.numberOfLikes = _newData.numberOfLikes! - 1;
      }
    }
    _newData.likeType = likeType;
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.authProvider;
    return Container(
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(15),
      ),
      constraints: const BoxConstraints(minWidth: 280, maxHeight: 300),
      margin: const EdgeInsetsDirectional.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: CustomNetworkImage(
              _newData.image ?? '',
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
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    if (_newData.source != null) ...[
                      CustomNetworkImage(
                        _newData.sourceImage ?? '',
                        radius: 5,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                    Text(
                      "${_newData.source != null ? '${_newData.source}' : ''}${_newData.publicationTime != null ? ' - ${_newData.publicationTime!.formatDate(context)}' : ''}",
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
          const Spacer(),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Container(
              color: context.colorPalette.grey9E9,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StatefulBuilder(builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        IconButton(
                          onPressed: () {
                            authProvider.checkIfUserAuthenticated(
                              context,
                              callback: () {
                                setState(() {
                                  _toggleLike(_newData.likeType == LikeType.like ? null : 1, true);
                                });
                              },
                            );
                          },
                          icon: CustomSvg(
                            _newData.likeType == LikeType.like ? MyIcons.heart : MyIcons.heartEmpty,
                            width: 25,
                            color: _newData.likeType == LikeType.like ? context.colorPalette.red000 : null,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        authProvider.checkIfUserAuthenticated(
                          context,
                          callback: () {
                            setState(() {
                              _toggleLike(_newData.likeType == LikeType.disLike ? null : 0, false);
                            });
                          },
                        );
                      },
                      icon: CustomSvg(
                        _newData.likeType == LikeType.disLike ? MyIcons.dislikeFilled : MyIcons.dislikeOutlined,
                        width: 25,
                        color: _newData.likeType == LikeType.disLike ? context.colorPalette.red000 : null,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        DeepLinkingService.share(
                          context,
                          id: _newData.id!.toString(),
                          type: DeepLinkingType.blog,
                          title: _newData.title!,
                          description: _newData.content!,
                          imageURL: _newData.image!,
                        );
                      },
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
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
