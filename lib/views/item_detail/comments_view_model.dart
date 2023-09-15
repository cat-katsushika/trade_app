import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/comment_model.dart';
import 'package:trade_app/repository/comment_repository.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepository();
});

final commentViewModelProvider = StateNotifierProvider<CommentViewModel, AsyncValue<List<Comment>>>((ref) {
  return CommentViewModel(ref.read(commentRepositoryProvider)); // リポジトリを注入
});

class CommentViewModel extends StateNotifier<AsyncValue<List<Comment>>> {
  final CommentRepository _repository;

  CommentViewModel( this._repository) : super(const AsyncValue.loading()) {}

  Future<void> fetchComments(String itemId) async {
    try {
      final apiUrl = '${Url.apiUrl}comment/?item_id=$itemId';
      final comments = await _repository.fetchComments(apiUrl); // リポジトリを使用してデータを取得
      state = AsyncValue.data(comments);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}
