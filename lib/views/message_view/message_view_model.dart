// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:trade_app/constant/url.dart';
// import 'package:trade_app/models/message_model.dart';
// import 'package:trade_app/repository/message_repository.dart';
//
// final messageRepositoryProvider = Provider<MessageRepository>((ref) {
//   return MessageRepository();
// });
//
// final messageViewModelProvider =
// StateNotifierProvider<MessageViewModel, AsyncValue<List<Message>>>((ref) {
//   return MessageViewModel(ref.read(messageRepositoryProvider)); // リポジトリを注入
// });
//
// class MessageViewModel extends StateNotifier<AsyncValue<List<Message>>> {
//   final MessageRepository _repository;
//
//   MessageViewModel(this._repository) : super(const AsyncValue.loading()) {
//     [];
//   }
//
//   Future<bool> postMessage(String itemId, String message, String userId) async {
//     try {
//       final apiUrl = '${Url.apiUrl}messages/?item_id=$itemId';
//       final isPost = await _repository.postMessage(
//         apiUrl,
//         Comment(
//           message: message,
//           createdAt: DateTime.now(),
//           itemId: itemId,
//           user: userId,
//         ),
//       );
//       if (isPost) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (err, stack) {
//       state = AsyncValue.error(err, stack);
//       return false;
//     }
//   }
//
//   Future<void> fetchMessages(String itemId) async {
//     try {
//       final apiUrl = '${Url.apiUrl}comment/?item_id=$itemId';
//       final comments =
//       await _repository.fetchMessages(apiUrl); // リポジトリを使用してデータを取得
//       state = AsyncValue.data(comments);
//     } catch (err, stack) {
//       state = AsyncValue.error(err, stack);
//     }
//   }
// }
