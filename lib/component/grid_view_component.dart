import 'package:flutter/material.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/item_detail/item_detail_view.dart';
import 'package:trade_app/views/top/item_card.dart';

class GridViewComponent extends StatelessWidget {
  const GridViewComponent({Key? key, required this.items}) : super(key: key);
  final List<Item> items;

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
              navigate: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemDetailView(items[index]),
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
