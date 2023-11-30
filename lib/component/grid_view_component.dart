import 'package:flutter/material.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/user_data_model.dart';
import 'package:trade_app/views/item_detail/item_detail_view.dart';
import 'package:trade_app/views/top/item_card.dart';

class GridViewComponent extends StatelessWidget {
  const GridViewComponent({Key? key, required this.items, required this.userData}) : super(key: key);
  final List<Item> items;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Text('検索結果は0件です。'),
        ),
      );
    } else {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ItemCard(
              item: items[index],
              userData: userData,
              navigate: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemDetailView(items[index], userData),
                  ),
                );
              },
            );
          },
          childCount: items.length,
        ),
      );
    }
  }
}
