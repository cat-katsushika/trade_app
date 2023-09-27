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
  ItemsQueryNotifier() : super({"name": "", "user": "", "page": 0});

  void changeQuery(Map<String, dynamic> query) {
    state = {...state, ...query};
  }

  void changeName(String search) {
    state = {...state, "name": search};
  }

  void changeUserQuery(String user) {
    state = {...state, "user": user};
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

  void resetItemsQuery() {
    state = {"name": "", "page": 0};
  }
}
