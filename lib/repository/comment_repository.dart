import 'package:dio/dio.dart';
import 'package:trade_app/models/comment_model.dart';

class CommentRepository {
  final Dio _dio = Dio(); // Dioクライアントの初期化

  Future<List<Comment>> fetchComments(String apiUrl) async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<Comment> comments = (response.data as List)
            .map((data) => Comment.fromJson(data))
            .toList();
        return comments;
      } else {
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }
}
