import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sportk/model/comment_model.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';

class CommentBubble extends StatefulWidget {
  final CommentData comment;

  const CommentBubble({
    super.key,
    required this.comment,
  });

  @override
  State<CommentBubble> createState() => _CommentBubbleState();
}

class _CommentBubbleState extends State<CommentBubble> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      value: 0,
      vsync: this,
    );
    _controller.forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
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
                  Row(
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
                        "المهيار زهره",
                        style: TextStyle(
                          color: context.colorPalette.blueD4B,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "209",
                        style: TextStyle(color: context.colorPalette.red000),
                      ),
                      IconButton(onPressed: () {}, icon: const CustomSvg(MyIcons.heartEmpty))
                    ],
                  ),
                ],
              ),
              Text(widget.comment.comment!),
            ],
          ),
        ),
      ),
    );
  }
}