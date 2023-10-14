import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trade_app/repository/other_repository.dart';

enum LikeStatus { unliked, liking, liked, failed }

class LikeButton extends StatefulWidget {
  final String apiUrl; // PATCHリクエストを送るAPIのURL

  const LikeButton({super.key, required this.apiUrl});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  LikeStatus _status = LikeStatus.unliked;

  Future<void> _toggleLike() async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    setState(() {
      _status = LikeStatus.liking;
    });

    try {
      final response = await dio.patch(widget.apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          _status = _status == LikeStatus.liked ? LikeStatus.unliked : LikeStatus.liked;
        });
      } else {
        setState(() {
          _status = LikeStatus.failed;
        });
      }
    } catch (error) {
      setState(() {
        _status = LikeStatus.failed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _status == LikeStatus.liking
          ? const CircularProgressIndicator()
          : Icon(
        _status == LikeStatus.liked ? Icons.favorite : Icons.favorite_outline,
        color: _status == LikeStatus.liked ? Colors.red : Colors.grey,
        size: 32,
      ),
      onPressed: _toggleLike,
    );
  }
}
