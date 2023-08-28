import 'package:flutter/material.dart';
import 'package:trade_app/component/comment_card.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/comment_model.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({Key? key}) : super(key: key);

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final List<Comment> comments = [
    const Comment(
      user: '8121040',
      comment: 'aaaaaaaaaaaaa'
    ),
    const Comment(
        user: '8121039',
        comment: 'iiiiiiiiiii'
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
              "コメント",
            style: MyTextStyles.mediumBold,
          ),
          for(var comment in comments)
            CommentCard(comment),
            const SizedBox(height: 16)
        ],
      ),
    );
  }
}
