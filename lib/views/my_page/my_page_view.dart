import 'package:flutter/material.dart';
import 'package:trade_app/views/top/item_grid_view.dart';
import 'package:trade_app/views/top/item_grid_view_model.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  Widget _tabText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3つのタブを持つ
      child: Scaffold(
        appBar: AppBar(
          title: const Text('マイページ'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: _tabText('購入'),
              ),
              Tab(
                child: _tabText('出品'),
              ),
              Tab(
                child: _tabText('いいね'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ItemGridView(
              provider: purchasedItemsProvider,
            ),
            ItemGridView(
              provider: listingItemsProvider,
            ),
            ItemGridView(
              provider: likeItemsProvider,
            ),
          ],
        ),
      ),
    );
  }
}
