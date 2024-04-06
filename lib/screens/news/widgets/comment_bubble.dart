import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/widgets/like_buttons.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class CommentBubble extends StatefulWidget {
  final int newId;
  final CommentData comment;
  final bool isReply;

  const CommentBubble({
    super.key,
    required this.comment,
    required this.newId,
    required this.isReply,
  });

  @override
  State<CommentBubble> createState() => _CommentBubbleState();
}

class _CommentBubbleState extends State<CommentBubble> with AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;
  late AuthProvider _authProvider;
  late CommonProvider _commonProvider;
  late CommentData _comment;

  late int _repliesCount;

  int? get _initialLikeType => widget.comment.likeType;
  int? get _initialNumberOfLikes => widget.comment.numberOfLikes;

  bool get _isReply => widget.isReply;

  void _toggleLike(int? likeType, bool fromLike) {
    if (likeType == LikeType.like) {
      _commonProvider.like(_comment.id!, likeType!, isComment: true);
      _comment.numberOfLikes = _comment.numberOfLikes! + 1;
    }
    if (likeType == LikeType.disLike) {
      _commonProvider.like(_comment.id!, likeType!, isComment: true);
      if (_comment.likeType == LikeType.like) {
        _comment.numberOfLikes = _comment.numberOfLikes! - 1;
      }
    }
    if (likeType == null) {
      _commonProvider.removeLike(_comment.id!, true);
      if (fromLike) {
        _comment.numberOfLikes = _comment.numberOfLikes! - 1;
      }
    }
    _comment.likeType = likeType;
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _commonProvider = context.commonProvider;
    print("ajskfhakjsfh:::: ${widget.comment.toJson()}");
    _comment = CommentData.fromJson(widget.comment.toJson());
    _repliesCount = _comment.replies!.length;
    print("_repliesCount::: ${_repliesCount}");
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
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomNetworkImage(
                      _comment.user!.profileImg!,
                      radius: 20,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      _comment.user!.name!,
                      style: TextStyle(
                        color: context.colorPalette.blueD4B,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                StatefulBuilder(
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
                              '${_comment.numberOfLikes}',
                              key: ValueKey<int>(_comment.numberOfLikes!),
                              style: TextStyle(color: context.colorPalette.red000),
                            ),
                          ),
                        ),
                        ZoomIn(
                          child: LikeButtons(
                            onPressed: (likeType, like) {
                              setState(() {
                                _toggleLike(likeType, like);
                              });
                            },
                            likeType: _comment.likeType,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_comment.comment!),
                ),
                if (!_isReply)
                  StatefulBuilder(builder: (context, setState) {
                    return TextButton(
                      onPressed: () {
                        UiHelper.showCommentsSheet(context, widget.newId, commentId: _comment.id).then((value) {
                          if (value != null && value) {
                            setState(() {
                              _repliesCount++;
                            });
                          }
                        });
                      },
                      child: Text(_repliesCount == 0 ? context.appLocalization.reply : "$_repliesCount ${_repliesCount > 1 ? context.appLocalization.replies : context.appLocalization.reply}"),
                    );
                  }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
