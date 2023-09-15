import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemsQueryProvider = StateNotifierProvider<ItemsQueryNotifier, Map<String, dynamic>>((ref) {
  return ItemsQueryNotifier();
});

class ItemsQueryNotifier extends StateNotifier<Map<String, dynamic>> {
  ItemsQueryNotifier() :  super({
    "name":"",
    "page":0
  });

  void changeQuery(Map<String, dynamic> query) {
    state=query;
  }

  void changeSearch(String search) {
    state = {...state, "name": search};
  }

  void incrementPage() {
    state = {...state, "page": state["page"] + 1};
  }

  void resetItemsQuery(){
    state={
      "name":"",
      "page": 0
    };
  }
}
