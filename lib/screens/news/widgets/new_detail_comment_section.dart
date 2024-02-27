import 'package:flutter/material.dart';
import 'package:sportk/alerts/errors/app_error_feedback.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/comments_screen.dart';
import 'package:sportk/screens/news/widgets/comment_bubble.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class NewDetailsCommentSection extends StatefulWidget {
  final int newId;

  const NewDetailsCommentSection({
    super.key,
    required this.newId,
  });

  @override
  State<NewDetailsCommentSection> createState() => _NewDetailsCommentSectionState();
}

class _NewDetailsCommentSectionState extends State<NewDetailsCommentSection> {
  late AuthProvider _authProvider;
  late CommonProvider _commonProvider;
  late TextEditingController _controller;

  int get _newId => widget.newId;

  void _addComment() async {
    await ApiFutureBuilder<CommentModel>().fetch(
      context,
      withOverlayLoader: false,
      future: () {
        final snapshot = ApiService<CommentModel>().build(
          weCanUrl: ApiUrl.comments,
          isPublic: false,
          apiType: ApiType.post,
          queryParams: {
            "blog_id": _newId,
            "comment": _controller.text,
          },
          builder: CommentModel.fromJson,
        );
        return snapshot;
      },
      onComplete: (snapshot) {},
      onError: (failure) => AppErrorFeedback.show(context, failure),
    );
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _commonProvider = context.commonProvider;
    _controller = TextEditingController();
    _controller.addListener(() {
      final text = _controller.text;
      if (text.isEmpty || text.length == 1) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return VexPaginator(
      query: (pageKey) async => _commonProvider.fetchComments(_newId, pageKey),
      onFetching: (snapshot) async => snapshot.data!,
      onLoading: () => Padding(
        padding: const EdgeInsets.only(top: 50),
        child: context.loaders.circular(isSmall: true),
      ),
      pageSize: 10,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.appLocalization.addComment,
              style: TextStyle(
                color: context.colorPalette.blueD4B,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: double.infinity,
              height: 105,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: context.colorPalette.grey3F3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage(
                          _authProvider.user.name ?? '',
                          radius: 20,
                          width: 30,
                          height: 30,
                          margin: const EdgeInsetsDirectional.only(end: 10),
                        ),
                        Text(
                          _authProvider.user.name ?? '',
                          style: TextStyle(
                            color: context.colorPalette.blueD4B,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              fillColor: context.colorPalette.white,
                              contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 10),
                              hintText: context.appLocalization.addCommentHere,
                            ),
                          ),
                        ),
                        IconButton.filled(
                          onPressed: _controller.text.isNotEmpty
                              ? () {
                                  setState(() {
                                    snapshot.docs.insert(
                                      0,
                                      CommentData(
                                        id: 999,
                                        userId: _authProvider.user.id,
                                        comment: _controller.text,
                                      ),
                                    );
                                  });
                                  _controller.clear();
                                  _addComment();
                                }
                              : null,
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          icon: const CustomSvg(
                            MyIcons.send,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.appLocalization.allComments,
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.push(CommentsScreen(newId: _newId));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              ],
            ),
            ListView.separated(
              itemCount: snapshot.docs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final comment = snapshot.docs[index] as CommentData;
                return CommentBubble(
                  key: ValueKey(comment.id), //
                  comment: comment,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
