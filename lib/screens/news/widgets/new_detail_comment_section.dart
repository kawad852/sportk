import 'package:flutter/material.dart';
import 'package:sportk/helper/ui_helper.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/widgets/comment_bubble.dart';
import 'package:sportk/screens/news/widgets/comment_editor.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_network_image.dart';
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

  int get _newId => widget.newId;

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _commonProvider = context.commonProvider;
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
      onError: (snapshot) => const SizedBox.shrink(),
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
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
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
                    CommentEditor(
                      newId: _newId,
                      onAdd: (comment) {
                        setState(() {
                          snapshot.docs.insert(
                            0,
                            comment,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 11),
            if (snapshot.docs.isNotEmpty) ...[
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
                      UiHelper.showCommentsSheet(context, _newId);
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
                  return CommentBubble(comment: comment);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
