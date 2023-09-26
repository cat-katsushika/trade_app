import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/models/comment_model.dart';
import 'package:trade_app/repository/other_repository.dart';

class CommentRepository {

  Future<List<Comment>> fetchComments(String apiUrl) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    try {
      dio.interceptors.add(LogInterceptor());
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<Comment> comments = (response.data as List)
            .map((data) => Comment.fromJson(data))
            .toList();
        debugPrint('fetched comments');
        return comments;
      } else {
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }
  Future<bool> postComment(String apiUrl, Comment comment) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    try {
      dio.interceptors.add(LogInterceptor());
      final response = await dio.post(
        apiUrl,
        data: comment.toJson(),
      );

      if (response.statusCode == 201) {
        debugPrint('Comment posted successfully');
        return true;
      } else {
        throw Exception('Failed to post comment');
      }
    } catch (e) {
      throw Exception('An error occurred while posting comment: $e');
    }
  }
}
