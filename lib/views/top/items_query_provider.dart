import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsQueryProvider =
    StateNotifierProvider<ItemsQueryNotifier, Map<String, dynamic>>((ref) {
  return ItemsQueryNotifier();
});

final likeItemsQueryProvider =
    StateNotifierProvider<ItemsQueryNotifier, Map<String, dynamic>>((ref) {
  return ItemsQueryNotifier();
});

final purchasedItemsQueryProvider =
    StateNotifierProvider<ItemsQueryNotifier, Map<String, dynamic>>((ref) {
  return ItemsQueryNotifier();
});

final listingItemsQueryProvider =
    StateNotifierProvider<ItemsQueryNotifier, Map<String, dynamic>>((ref) {
  return ItemsQueryNotifier();
});

class ItemsQueryNotifier extends StateNotifier<Map<String, dynamic>> {
  ItemsQueryNotifier() : super({"name": "", "page": 0, "listing_status":""});

  void changeQuery(Map<String, dynamic> query) {
    state = {...state, ...query};
  }

  void changeName(String search) {
    state = {...state, "name": search};
  }

  void changeIsShowSoldItem(bool isShow) {
    if (isShow) {
      state = {...state, "listing_status": ""};
    } else {
      state = {...state, "listing_status": "unpurchased"};
    }
  }

  void incrementPage() {
    state = {...state, "page": state["page"] + 1};
  }

  void resetPage() {
    state = {...state, "page": 1};
  }
}
