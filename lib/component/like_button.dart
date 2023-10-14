import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/repository/other_repository.dart';

enum LikeStatus { undefined, unliked, liking, liked, failed }

class LikeButton extends StatefulWidget {
  final String apiUrl;
  final bool isLike;

  const LikeButton({super.key, required this.apiUrl, required this.isLike});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  static LikeStatus _status = LikeStatus.undefined;

  @override
  void initState() {
    if (_status==LikeStatus.undefined&&widget.isLike) {
      _status = LikeStatus.liked;
    }

    super.initState();
  }

  Future<bool> _toggleLike() async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    setState(() => _status = LikeStatus.liking);
    try {
      final response = await dio.post(widget.apiUrl);
      print(response);
      if (response.statusCode == 200) {
        if (response.data['message'] == Texts.likeToggleOnMessage) {
          setState(() => _status = LikeStatus.liked);
        } else if (response.data['message'] == Texts.likeToggleOffMessage) {
          setState(() => _status = LikeStatus.unliked);
        }
      } else {
        setState(() => _status = LikeStatus.failed);
        return false;
      }
      return true;
    } catch (error) {
      debugPrint(error.toString());
      setState(() => _status = LikeStatus.failed);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _status == LikeStatus.liking
          ? const CircularProgressIndicator()
          : Icon(
              _status == LikeStatus.liked
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: _status == LikeStatus.liked ? Colors.red : Colors.grey,
              size: 32,
            ),
      onPressed: _toggleLike,
    );
  }
}
