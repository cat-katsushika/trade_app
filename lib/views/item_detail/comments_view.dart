import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/comment_card.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/item_detail/comments_view_model.dart';

class CommentsView extends ConsumerStatefulWidget {
  const CommentsView({Key? key, required this.newCommentController, required this.item})
      : super(key: key);
  final TextEditingController newCommentController;
  final Item item;

  @override
  ConsumerState createState() => _CommentsViewState();
}

class _CommentsViewState extends ConsumerState<CommentsView> {
  @override
  void initState() {
    ref.read(commentViewModelProvider.notifier).fetchComments(widget.item.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(commentViewModelProvider).when(data: (comments) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "コメント",
                    style: MyTextStyles.mediumBold,
                  ),
                ),
                for (var comment in comments) CommentCard(comment),
              ],
            ),
            // if(comments.isEmpty)
            //   Padding(
            //     padding: const EdgeInsets.fromLTRB(0, 0, 8, 16),
            //     child: const Text('コメントはまだありません。'),
            //   ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: widget.newCommentController,
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
                    onPressed: () {
                      //TODO  providerに変更 コメント送信
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }, error: (err, stack) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('エラー'),
      //   ),
      // );
      return const Center(child: Text('コメントが読み込めません'));
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
