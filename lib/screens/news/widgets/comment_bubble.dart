import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/comment_like_model.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/model/is_like_model.dart';
import 'package:sportk/model/user_model.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/shimmer/shimmer_bubble.dart';
import 'package:sportk/widgets/shimmer/shimmer_loading.dart';

class CommentBubble extends StatefulWidget {
  final CommentData comment;

  const CommentBubble({
    super.key,
    required this.comment,
  });

  @override
  State<CommentBubble> createState() => _CommentBubbleState();
}

class _CommentBubbleState extends State<CommentBubble> with AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;
  late AuthProvider _authProvider;
  late CommonProvider _commonProvider;
  late Future<UserModel> _userFuture;
  late Future<List<dynamic>> _likeFuture;

  CommentData get _comment => widget.comment;

  void _initializeUserFuture() {
    _userFuture = _authProvider.getUserProfile(_comment.userId!);
  }

  void _initializeLikeFuture() {
    final isLikeFuture = _commonProvider.fetchIsLike(_comment.id!);
    final likeCountFuture = _commonProvider.fetchCommentLikes(_comment.id!);
    _likeFuture = Future.wait([isLikeFuture, likeCountFuture]);
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _commonProvider = context.commonProvider;
    _initializeUserFuture();
    _initializeLikeFuture();
    // _controller = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // );
    // _controller.forward();
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  // @override
  // void didUpdateWidget(covariant CommentBubble oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.comment != oldWidget.comment) {
  //     _controller.reset(); // Reset animation when item changes (optional)
  //     _controller.forward();
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFutureBuilder(
                  future: _userFuture,
                  onRetry: () {},
                  onLoading: () {
                    return const ShimmerLoading(
                      child: Row(
                        children: [
                          CircleAvatar(radius: 15),
                          LoadingBubble(
                            height: 20,
                            width: 100,
                            radius: 30,
                            margin: EdgeInsetsDirectional.only(start: 10),
                          ),
                        ],
                      ),
                    );
                  },
                  onError: (snapshot) {
                    return const Row(
                      children: [
                        CircleAvatar(radius: 15),
                        Text(
                          "    -   ",
                        ),
                      ],
                    );
                  },
                  onComplete: (context, snapshot) {
                    final user = snapshot.data!.data!;
                    return Row(
                      children: [
                        const CustomNetworkImage(
                          kFakeImage,
                          radius: 20,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user.name!,
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                  child: CustomFutureBuilder(
                    future: _likeFuture,
                    onRetry: () {},
                    onLoading: () => const SizedBox(width: 30),
                    onError: (snapshot) => const SizedBox(width: 30),
                    onComplete: (context, snapshot) {
                      final isLike = snapshot.data![0] as IsLikeModel;
                      final likeCount = snapshot.data![1] as CommentLikeModel;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Row(
                            children: [
                              ZoomIn(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 350),
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return ScaleTransition(scale: animation, child: child);
                                  },
                                  child: Text(
                                    '${likeCount.like}',
                                    key: ValueKey<int>(likeCount.like!),
                                    style: TextStyle(color: context.colorPalette.red000),
                                  ),
                                ),
                              ),
                              ZoomIn(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isLike.like = !isLike.like!;
                                      if (isLike.like!) {
                                        likeCount.like = likeCount.like! + 1;
                                      } else {
                                        likeCount.like = likeCount.like! - 1;
                                      }
                                    });
                                  },
                                  icon: CustomSvg(isLike.like! ? MyIcons.heart : MyIcons.heartEmpty),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Text(_comment.comment!),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
