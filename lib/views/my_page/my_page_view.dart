import 'package:flutter/material.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/views/top/item_grid_view.dart';
import 'package:trade_app/views/top/item_list_view_model.dart';
import 'package:trade_app/views/top/items_query_provider.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3つのタブを持つ
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: '購入物'),
              Tab(text: '出品物'),
              Tab(text: 'いいね'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ItemGridView(
              url: '',
              provider: purchasedItemsProvider,
              queryProvider: purchasedItemsQueryProvider,
            ),
            ItemGridView(
              url: '',
              provider: listingItemsProvider,
              queryProvider: listingItemsQueryProvider,
            ),
            ItemGridView(
              url: '${Url.apiUrl}items/profile/like/',
              provider: likeItemsProvider,
              queryProvider: likeItemsQueryProvider,
            ),
          ],
        ),
      ),
    );
  }
}
