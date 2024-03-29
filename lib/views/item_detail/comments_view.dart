import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/comment_card.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/views/item_detail/message_view_model.dart';

class CommentsView extends ConsumerStatefulWidget {
  const CommentsView({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  ConsumerState createState() => _CommentsViewState();
}

class _CommentsViewState extends ConsumerState<CommentsView> {
  final newCommentController = TextEditingController();

  @override
  void initState() {
    ref
        .read(commentViewModelProvider.notifier)
        .fetchMessages(widget.item.id, Url.com);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listingStatus =
        ListingStatus.values.byName(widget.item.listingStatus);
    final userDataState = ref.read(userDataProvider);
    return ref.watch(commentViewModelProvider).when(data: (comments) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "コメント",
                  style: MyTextStyles.mediumBold,
                ),
              ),
              for (var comment in comments) CommentCard(comment),
            ],
          ),
          if (listingStatus == ListingStatus.unpurchased)
            Row(
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
                            .watch(commentViewModelProvider.notifier)
                            .postMessage(
                              widget.item.id,
                              newCommentController.text,
                              userDataState.id,
                              Url.com,
                            );
                        if (isPost) {
                          newCommentController.text = '';
                          ref
                              .read(commentViewModelProvider.notifier)
                              .fetchMessages(widget.item.id, Url.com);
                        } else {
                          Future(
                              () => ScaffoldMessenger.of(context).showSnackBar(
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
        ],
      );
    }, error: (err, stack) {
      return const Center(child: Text('コメントが読み込めません'));
    }, loading: () {
      return const Center(child: CupertinoActivityIndicator());
    });
  }
}
