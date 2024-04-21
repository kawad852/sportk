import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/base_editor.dart';
import 'package:sportk/widgets/custom_svg.dart';

class ChatEditor extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final VoidCallback? onEmojiTap;
  final VoidCallback onTap;

  const ChatEditor({
    super.key,
    required this.controller,
    required this.onPressed,
    this.onEmojiTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 8, 13, 8),
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
      ),
      child: Row(
        children: [
          // const CustomSvg(MyIcons.chat),
          IconButton(
            onPressed: onEmojiTap,
            icon: const Icon(FontAwesomeIcons.faceSmile),
          ),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: MyTheme.inputDecorationTheme(
                  context,
                  context.colorScheme,
                ).copyWith(
                  fillColor: context.colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              child: BaseEditor(
                controller: controller,
                keyboardType: TextInputType.multiline,
                onTapOutside: () {},
                onTap: onTap,
                maxLines: null,
                padding: const EdgeInsetsDirectional.only(end: 10),
                hintText: context.appLocalization.chatHint,
              ),
            ),
          ),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              minimumSize: const Size(30, 30),
            ),
            child: CustomSvg(
              MyIcons.directUp,
              color: context.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
