import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/message_model.dart';
import 'package:trade_app/repository/message_repository.dart';


//購入後のメッセージを管理
final messageViewModelProvider =
    StateNotifierProvider<MessageViewModel, AsyncValue<List<Message>>>((ref) {
  return MessageViewModel(ref.read(messageRepositoryProvider)); // リポジトリを注入
});

//購入前のコメントを管理
final commentViewModelProvider =
StateNotifierProvider<MessageViewModel, AsyncValue<List<Message>>>((ref) {
  return MessageViewModel(ref.read(messageRepositoryProvider)); // リポジトリを注入
});

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepository();
});

class MessageViewModel extends StateNotifier<AsyncValue<List<Message>>> {
  final MessageRepository _repository;

  MessageViewModel(this._repository) : super(const AsyncValue.loading()) {
    [];
  }

  Future<bool> postMessage(String itemId, String message, String userId, String msgOrCom) async {
    final apiUrl = '${Url.apiUrl}$msgOrCom/create/';
    state = const AsyncValue.loading();
    try {
      final isPost = await _repository.postMessage(
        apiUrl,
        Message(
          message: message,
          createdAt: DateTime.now(),
          itemId: itemId,
          user: userId,
        ),
      );
      if (isPost) {
        return true;
      } else {
        return false;
      }
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      return false;
    }
  }

  Future<void> fetchMessages(String itemId, String msgOrCom) async {
    final apiUrl = '${Url.apiUrl}$msgOrCom/?item_id=$itemId';
    try {
      final messages =
          await _repository.fetchMessages(apiUrl); // リポジトリを使用してデータを取得
      state = AsyncValue.data(messages);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}
