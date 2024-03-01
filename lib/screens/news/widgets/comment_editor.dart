import 'package:flutter/material.dart';
import 'package:sportk/alerts/errors/app_error_feedback.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/base_editor.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';

// registration
// leagues
// favorites

// home
// blogs

// guest

class CommentEditor extends StatefulWidget {
  final int newId;

  final Function(CommentData comment) onAdd;

  const CommentEditor({
    super.key,
    required this.newId,
    required this.onAdd,
  });

  @override
  State<CommentEditor> createState() => _CommentEditorState();
}

class _CommentEditorState extends State<CommentEditor> {
  late CommonProvider _commonProvider;
  late TextEditingController _controller;
  Future<CommentModel>? _commentFuture;

  Future<void> _addComment() async {
    ApiFutureBuilder<CommentModel>().fetch(
      context,
      withOverlayLoader: false,
      future: () {
        _commentFuture = ApiService<CommentModel>().build(
          weCanUrl: ApiUrl.comments,
          isPublic: false,
          apiType: ApiType.post,
          queryParams: {
            "blog_id": widget.newId,
            "comment": _controller.text,
          },
          builder: CommentModel.fromJson,
        );
        return _commentFuture!;
      },
      onComplete: (snapshot) {
        setState(() {
          _commentFuture = null;
        });
        _controller.clear();
        widget.onAdd(snapshot.data!);
      },
      onError: (failure) {
        setState(() {
          _commentFuture = null;
        });
        AppErrorFeedback.show(context, failure);
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseEditor(
            controller: _controller,
            filled: true,
            fillColor: context.colorPalette.white,
            hintText: context.appLocalization.addCommentHere,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
        IconButton.filled(
          onPressed: _controller.text.isNotEmpty
              ? () async {
                  setState(() {
                    _addComment();
                  });
                }
              : null,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          icon: _commentFuture == null
              ? const CustomSvg(
                  MyIcons.send,
                )
              : CustomFutureBuilder(
                  future: _commentFuture!,
                  onRetry: () {},
                  onError: (snapshot) => const SizedBox.shrink(),
                  onLoading: () => SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.8,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                  onComplete: (context, index) {
                    return const CustomSvg(
                      MyIcons.send,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
