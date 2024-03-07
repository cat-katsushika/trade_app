import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/comment_card.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/item_detail/message_view_model.dart';

class MessageView<T> extends ConsumerStatefulWidget {
  const MessageView(
      {Key? key,
      required this.isComment,
      required this.item,
      this.onTapComplete,
      required this.isShowCompleteButton})
      : super(key: key);
  final Item item;
  final VoidCallback? onTapComplete;
  final bool isShowCompleteButton;
  final bool isComment;

  @override
  ConsumerState createState() => _MessageViewState();
}

class _MessageViewState extends ConsumerState<MessageView> {
  final newCommentController = TextEditingController();
  var provider = commentViewModelProvider;
  @override
  void initState() {
    widget.isComment
        ? provider = commentViewModelProvider
        : provider = messageViewModelProvider;
    ref
        .read(provider.notifier)
        .fetchMessages(widget.item.id, widget.isComment ? Url.com : Url.msg);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDataState = ref.read(userDataProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ref.watch(provider).when(data: (comments) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widget.isShowCompleteButton
                                ? ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialogComponent(
                                          alertMessage: '取引を完了しますか',
                                          leftText: '完了する',
                                          rightText: Texts.buttonPopText,
                                          onTap: () => widget.onTapComplete,
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              MyColors.tertiary),
                                    ),
                                    child: const Text(
                                      "取引を完了する",
                                      style: TextStyle(color: MyColors.white),
                                    ),
                                  )
                                : const SizedBox(height: 50)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                widget.isComment ? "コメント" : "メッセージ",
                                style: MyTextStyles.mediumBold,
                              ),
                            ),
                            for (var comment in comments) CommentCard(comment),
                          ],
                        ),
                        const SizedBox(height: 8),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 5,
                                child: TextField(
                                  controller: newCommentController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: MyColors.grey,
                                      ), // 通常のボーダーの色
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: MyColors.primary,
                                      ), // フォーカスされたときのボーダーの色
                                    ),
                                    labelText: widget.isComment
                                        ? 'コメントする'
                                        : 'メッセージを送信',
                                    alignLabelWithHint: true,
                                    hintText: widget.isComment
                                        ? 'コメントする'
                                        : 'メッセージを送信',
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: GestureDetector(
                                    onTap: () async {
                                      String url = Url.msg;
                                      widget.isComment
                                          ? url = Url.com
                                          : Url.msg;
                                      if (newCommentController.text != '') {
                                        final isPost = await ref
                                            .watch(provider.notifier)
                                            .postMessage(
                                              widget.item.id,
                                              newCommentController.text,
                                              userDataState.id,
                                              url,
                                            );
                                        if (isPost) {
                                          newCommentController.text = '';
                                          ref
                                              .read(provider.notifier)
                                              .fetchMessages(
                                                  widget.item.id, url);
                                        } else {
                                          Future(() =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text('投稿できませんでした'),
                                                ),
                                              ));
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '送信',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: MyColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
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
            );
          }, error: (err, stack) {
            return const Text('メッセージが読み込めません');
          }, loading: () {
            return const CupertinoActivityIndicator();
          }),
        ),
      ),
    );
  }
}
