import 'package:flutter/material.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/news/widgets/comment_bubble.dart';
import 'package:sportk/screens/news/widgets/comment_editor.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/vex/vex_loader.dart';
import 'package:sportk/widgets/vex/vex_paginator.dart';

class CommentsScreen extends StatefulWidget {
  final int newId;
  final bool isReply;

  const CommentsScreen({
    super.key,
    required this.newId,
    required this.isReply,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late CommonProvider _commonProvider;

  int get _newId => widget.newId;
  bool get _isReply => widget.isReply;

  @override
  void initState() {
    super.initState();
    _commonProvider = context.commonProvider;
  }

  @override
  Widget build(BuildContext context) {
    return VexPaginator(
      query: (pageKey) async => _commonProvider.fetchComments(_newId, pageKey),
      onFetching: (snapshot) async => snapshot.data!,
      pageSize: 10,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          bottomSheet: BottomAppBar(
            child: CommentEditor(
              newId: _newId,
              onAdd: (comment) {
                setState(() {
                  snapshot.docs.insert(0, comment);
                });
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                titleTextStyle: context.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                title: Text(
                  _isReply ? context.appLocalization.replies : context.appLocalization.comments,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.docs.length + 1,
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  padding: const EdgeInsets.all(20).copyWith(bottom: 80),
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }

                    if (index == snapshot.docs.length) {
                      return VexLoader(snapshot.isFetchingMore);
                    }

                    final comment = snapshot.docs[index] as CommentData;
                    return CommentBubble(
                      comment: comment,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
