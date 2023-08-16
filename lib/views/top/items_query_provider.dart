import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemQueryProvider = StateNotifierProvider<ItemQueryNotifier, Map<String, dynamic>>((ref) {
  return ItemQueryNotifier();
});

class ItemQueryNotifier extends StateNotifier<Map<String, dynamic>> {
  ItemQueryNotifier() :  super({
    "search":"",
    "page":0
  });

  void incrementPage() {
    state["page"]++;
  }

  void resetItemQuery(){
    state={
      "search":"",
      "page":"0"
    };
  }
}
