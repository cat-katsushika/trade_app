import 'package:flutter/material.dart';
import 'package:trade_app/component/comment_card.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/comment_model.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({Key? key, required this.newCommentController})
      : super(key: key);
  final TextEditingController newCommentController;

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  Future<List<Comment>> fetchComment() async {
    //TODO:通信
    Future.delayed(const Duration(seconds: 3));
    final List<Comment> comments = [
      const Comment(user: '8121040', comment: 'aaaaaaaaaaaaa'),
      const Comment(user: '8121039', comment: 'iiiiiiiiiii'),
    ];
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          FutureBuilder<List<Comment>>(
              future: fetchComment(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "コメント",
                        style: MyTextStyles.mediumBold,
                      ),
                      for (var comment in snapshot.data!) CommentCard(comment),
                      const SizedBox(height: 16)
                    ],
                  );
                } else if (snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('エラー'),
                    ),
                  );
                  return const Center(child: Text('エラー'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
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
                    //TODO providerに変更
                    //TODO コメント送信
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
