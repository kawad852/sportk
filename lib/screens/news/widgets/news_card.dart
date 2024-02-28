import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/is_like_model.dart';
import 'package:sportk/model/new_like_model.dart';
import 'package:sportk/model/new_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/news_details_screen.dart';
import 'package:sportk/screens/news/widgets/like_button.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
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
  late Future<List<dynamic>> _likeFuture;
  late CommonProvider _commonProvider;

  void _initializeLikesFuture() {
    final isLikeFuture = ApiService<IsLikeModel>().build(
      weCanUrl: '${ApiUrl.newLikeCheck}/${widget.newData.id}',
      isPublic: false,
      apiType: ApiType.get,
      builder: IsLikeModel.fromJson,
    );
    final likeCountFuture = ApiService<NewLikeModel>().build(
      weCanUrl: '${ApiUrl.newLikes}/${widget.newData.id}',
      isPublic: false,
      apiType: ApiType.get,
      builder: NewLikeModel.fromJson,
    );
    _likeFuture = Future.wait([isLikeFuture, likeCountFuture]);
  }

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
    _initializeLikesFuture();
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
              context.image(widget.newData.image!),
              onTap: () {
                context.push(NewsDetailsScreen(newId: widget.newData.id!));
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
                  widget.newData.title!,
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
                      context.image(widget.newData.image!),
                      radius: 5,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.newData.source} - ${widget.newData.publicationTime!.formatDate(context)}",
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
                    CustomFutureBuilder(
                      future: _likeFuture,
                      onRetry: () {},
                      onLoading: () => const SizedBox(width: 60),
                      onError: (snapshot) => const SizedBox(width: 60),
                      onComplete: (context, snapshot) {
                        final isLike = snapshot.data![0] as IsLikeModel;
                        final likeCount = snapshot.data![1] as NewLikeModel;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Row(
                              children: [
                                ZoomIn(
                                  child: LikeButton(
                                    isLike: isLike.like!,
                                    onPressed: () {
                                      setState(() {
                                        isLike.like = !isLike.like!;
                                        if (isLike.like!) {
                                          likeCount.numberOfLike = likeCount.numberOfLike! + 1;
                                          _commonProvider.like(widget.newData.id!, isComment: false);
                                        } else {
                                          likeCount.numberOfLike = likeCount.numberOfLike! - 1;
                                          _commonProvider.disLike(widget.newData.id!);
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
                                      "${likeCount.numberOfLike}",
                                      key: ValueKey<int>(likeCount.numberOfLike!),
                                      style: TextStyle(color: context.colorPalette.red000),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
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
                        UiHelper.showCommentsSheet(context, widget.newData.id!);
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
