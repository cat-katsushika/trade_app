import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/item_repository_provider.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

final itemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider));
});

//アプリの状態を管理し、必要に応じてItemRepositoryを使用して商品一覧データを取得
class ItemsNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  ItemsNotifier(this._repository) : super(const AsyncValue.loading());

  final ItemRepository _repository;

  void addItems(List<Item> items) {
    final oldData = state.value ?? [];
    state = AsyncValue.data([...oldData, ...items]);
  }

  void removeAll() {
    state = const AsyncValue.data([]);
  }

  Future<void> fetchItems(Map<String, dynamic>? query) async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.fetchItems(query);
      addItems(items);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}
