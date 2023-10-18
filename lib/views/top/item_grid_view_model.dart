import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/item_repository_provider.dart';

//全体の商品
final itemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider));
});

//いいねした商品
final likeItemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider));
});

//買った商品
final purchasedItemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider));
});

//販売中
final listingItemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider));
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

//〇〇商品一覧データを管理する雛形
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

  Future<void> fetchItems(Map<String, dynamic>? query, String url) async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.fetchItems(query, url);
      addItems(items);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  void toggleLike(String id, bool isLike){
    if(state.value!=null) {
      final targetItemIndex = state.value!.indexWhere((element) => element.id==id);
      if(targetItemIndex>=0) {
        state.value![targetItemIndex] = state.value![targetItemIndex].copyWith(isLikedByCurrentUser: isLike);
      }
    }
  }
}
