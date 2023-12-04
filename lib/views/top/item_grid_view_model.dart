import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/item_repository.dart';

//全体の商品
final itemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(ref.read(itemRepositoryProvider), '${Url.apiUrl}items/');
});

//いいねした商品
final likeItemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(
      ref.read(itemRepositoryProvider), '${Url.apiUrl}items/user/like');
});

//買った商品
final purchasedItemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(
      ref.read(itemRepositoryProvider), '${Url.apiUrl}items/user/buy');
});

//販売中
final listingItemsProvider =
    StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemsNotifier(
      ref.read(itemRepositoryProvider), '${Url.apiUrl}items/user/sell');
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

//〇〇商品一覧データを管理する雛形
class ItemsNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  ItemsNotifier(this._repository, this.apiUrl)
      : super(const AsyncLoading<List<Item>>()) {
    // Providerが初めて呼び出されたときに実行
    fetch();
  }

  final String apiUrl;

  int page = 1;
  String name = '';
  bool isShowSoldItem = false;

  final ItemRepository _repository;

  void changeName(String str) {
    page = 1;
    name = str;
  }

  Future<void> fetch({
    bool isLoadMore = false,
  }) async {
    final url = isShowSoldItem ? "$apiUrl?purchased=true" : "$apiUrl?purchased=false";
    state = await AsyncValue.guard(() async {
      final items = await _repository.fetchItems(name, page, url);
      print('---$url---$state---');
      return [if (isLoadMore) ...state.value ?? [], ...items];
    });
  }

  void loadMore() {
    // ローディング中にローディングしないようにする
    if (state == const AsyncLoading<List<Item>>().copyWithPrevious(state)) {
      return;
    }
    // 取得済みのデータを保持しながら状態をローディング中にする
    state = const AsyncLoading<List<Item>>().copyWithPrevious(state);
    page++;
    fetch(isLoadMore: true);
  }

  void refresh() {
    // 取得済みのデータを保持しながら状態をローディング中にする
    state = const AsyncLoading<List<Item>>().copyWithPrevious(state);
    page = 1;
    fetch();
  }

  Future<void> removeAll() async {
    state = const AsyncLoading<List<Item>>();
  }

  bool getIsShowSoldItem() => isShowSoldItem;

  void setIsShowSoldItem(bool isShow) async {
    isShowSoldItem = isShow;
    // await removeAll();
    page = 1;
    fetch();
  }

  void toggleLike(String id, bool isLike) {
    if (state.value != null) {
      final targetItemIndex =
          state.value!.indexWhere((element) => element.id == id);
      if (targetItemIndex >= 0) {
        state.value![targetItemIndex] = state.value![targetItemIndex]
            .copyWith(isLikedByCurrentUser: isLike);
      }
    }
  }
}
