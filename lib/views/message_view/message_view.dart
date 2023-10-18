import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/comment_card.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/item_detail/message_view_model.dart';

class MessageView extends ConsumerStatefulWidget {
  const MessageView({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  ConsumerState createState() => _CommentsViewState();
}

class _CommentsViewState extends ConsumerState<MessageView> {
  final newCommentController = TextEditingController();

  @override
  void initState() {
    ref
        .read(messageViewModelProvider.notifier)
        .fetchMessages(widget.item.id, Url.msg);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDataState = ref.read(userDataProvider);
    return ref.watch(messageViewModelProvider).when(data: (comments) {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "メッセージ",
                              style: MyTextStyles.mediumBold,
                            ),
                          ),
                          for (var comment in comments) CommentCard(comment),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextField(
                                controller: newCommentController,
                                decoration: const InputDecoration(
                                  labelText: 'コメント',
                                  border: OutlineInputBorder(),
                                  alignLabelWithHint: true,
                                  hintText: 'コメント',
                                ),
                                maxLines: 1,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () async {
                                  if (newCommentController.text != '') {
                                    final isPost = await ref
                                        .watch(messageViewModelProvider.notifier)
                                        .postMessage(
                                          widget.item.id,
                                          newCommentController.text,
                                          userDataState.id,
                                          Url.msg,
                                        );
                                    if (isPost) {
                                      newCommentController.text = '';
                                      ref
                                          .read(messageViewModelProvider.notifier)
                                          .fetchMessages(widget.item.id, Url.msg);
                                    } else {
                                      Future(() =>
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('投稿できませんでした'),
                                            ),
                                          ));
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.send,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }, error: (err, stack) {
      return const Scaffold(body: Center(child: Text('メッセージが読み込めません')));
    }, loading: () {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
