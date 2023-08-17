import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/item_repository_provider.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

final itemsProvider = StateNotifierProvider<ItemsNotifier, List<Item>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider));
});


//アプリの状態を管理し、必要に応じてItemRepositoryを使用して商品一覧データを取得
class ItemsNotifier extends StateNotifier<List<Item>> {
  ItemsNotifier(this._repository) :  super([]);

  final ItemRepository _repository;

  void addItems(List<Item> items) {
    state = [...state, ...items];
  }

  void removeAll() {
    state = [];
  }

  Future<void> fetchItems(Map<String,dynamic>? query) async {
    try {
      final items = await _repository.fetchItems(query);
      addItems(items);
    } catch (e) {
      throw Exception('Failed to load items');
    }
  }
}
