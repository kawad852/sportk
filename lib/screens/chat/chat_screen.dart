import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:sportk/model/chat_model.dart';
import 'package:sportk/providers/auth_provider.dart';
import 'package:sportk/screens/chat/widgets/chat_bubble.dart';
import 'package:sportk/screens/chat/widgets/chat_editor.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/widgets/custom_firestore_query_builder.dart';

class ChatScreen extends StatefulWidget {
  final int matchId;

  const ChatScreen({
    super.key,
    required this.matchId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late AuthProvider _authProvider;
  late Query<ChatModel> _chatQuery;
  FirebaseFirestore get _firebaseFirestore => FirebaseFirestore.instance;
  late TextEditingController _controller;
  bool _isEmojiShown = false;

  int get _matchId => widget.matchId;

  CollectionReference get _chatRef => _firebaseFirestore.collection('chats').doc('$_matchId').collection('messages');

  void _createMatchDocument() async {
    final documentRef = _firebaseFirestore.collection('chats').doc('$_matchId');
    final documentSnapshot = await documentRef.get();
    if (!documentSnapshot.exists) {
      documentRef.set({
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  void _sendMessage() {
    var chatJson = ChatModel(
      message: _controller.text,
      userId: _authProvider.user.id,
      photoURL: _authProvider.user.profileImg,
    ).toJson();
    chatJson['createdAt'] = FieldValue.serverTimestamp();
    _chatRef.doc().set(chatJson);
    setState(() {
      _controller.clear();
    });
  }

  void _toggleEmojiAppearance() {
    setState(() {
      _isEmojiShown = !_isEmojiShown;
    });
    if (_isEmojiShown) {
      context.unFocusKeyboard();
    }
  }

  void _initializeQuery() {
    _chatQuery = _chatRef.orderBy('createdAt', descending: true).withConverter<ChatModel>(
          fromFirestore: (snapshot, _) => ChatModel.fromJson(snapshot.data()!),
          toFirestore: (snapshot, _) => snapshot.toJson(),
        );
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _controller = TextEditingController();
    _controller.addListener(() {
      final text = _controller.text;
      if ((text.isEmpty || text.length == 1) && !_isEmojiShown) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
    _createMatchDocument();
    _initializeQuery();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(context.appLocalization.chat),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20).copyWith(bottom: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.grey3F3,
                borderRadius: BorderRadius.circular(MyTheme.radiusPrimary),
              ),
              child: CustomFirestoreQueryBuilder(
                query: _chatQuery,
                onComplete: (context, snapshot) {
                  if (snapshot.docs.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return ListView.separated(
                    itemCount: snapshot.docs.length,
                    reverse: true,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    itemBuilder: (context, index) {
                      if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                        snapshot.fetchMore();
                      }

                      if (index == snapshot.docs.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: context.loaders.circular(),
                        );
                      }

                      final chat = snapshot.docs[index].data();
                      return ChatBubble(
                        chat.message!,
                        imageURL: chat.photoURL ?? '',
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SafeArea(
            top: false,
            bottom: !_isEmojiShown,
            child: ChatEditor(
              controller: _controller,
              onTap: () {
                setState(() {
                  _isEmojiShown = false;
                });
              },
              onPressed: _controller.text.isNotEmpty
                  ? () {
                      _sendMessage();
                    }
                  : null,
              onEmojiTap: () {
                _toggleEmojiAppearance();
              },
            ),
          ),
          Offstage(
            offstage: !_isEmojiShown,
            child: EmojiPicker(
              textEditingController: _controller,
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
                ),
                swapCategoryAndBottomBar: false,
                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
                searchViewConfig: const SearchViewConfig(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
