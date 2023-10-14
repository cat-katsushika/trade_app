import 'package:flutter/material.dart';
import 'package:trade_app/models/comment_model.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.userEmail.split('@').first, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(comment.comment),
          ),
        ],
      ),
    );
  }
}