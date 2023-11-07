import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemsQueryNotifier extends StateNotifier<Map<String, dynamic>> {
  ItemsQueryNotifier() : super({"name": "","listing_status":""});

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

  void resetPage() {
    state = {...state, "page": 1};
  }
}
