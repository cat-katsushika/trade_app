import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/grid_view_component.dart';
import 'package:trade_app/component/on_going_bottom.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/error/network_error_view.dart';
import 'package:trade_app/views/top/item_grid_view_model.dart';

class ItemGridView extends ConsumerStatefulWidget {
  const ItemGridView({
    required this.provider,
    super.key,
  });

  final StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>> provider;

  @override
  ConsumerState createState() => _ItemGridViewState();
}

class _ItemGridViewState extends ConsumerState<ItemGridView> {

  @override
  void initState() {
    ref.read(widget.provider.notifier).fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Item>> asyncValue = ref.watch(widget.provider);
    final userData = ref.read(userDataProvider);
    return NotificationListener<ScrollEndNotification>(
      child: Scrollbar(
        child: CustomScrollView(
          primary: false,
          restorationId: 'articles',
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                ref.read(widget.provider.notifier).refresh();
              },
            ),
            asyncValue.when(
              data: (items) {
                return GridViewComponent(items: items, userData: userData);
              },
              error: (error, stacktrace) {
                if (asyncValue.hasValue) {
                  return GridViewComponent(items: asyncValue.value!, userData: userData,);
                }
                debugPrint(error.toString());
                return SliverToBoxAdapter(
                  child: NetworkErrorView(onRetry: () {
                    ref.read(userDataProvider.notifier).refreshAccessToken();
                    ref.read(widget.provider.notifier).refresh();
                  }),
                );
              },
              loading: () => const SliverToBoxAdapter(
                  child: Center(child: CupertinoActivityIndicator())),
            ),
            OnGoingBottom(
              asyncValue: asyncValue,
            ),
          ],
        ),
      ),
      onNotification: (notification) {
        // 一番下までスクロールしたとき
        if (notification.metrics.extentAfter == 0) {
          // 追加でローディング
          ref.read(widget.provider.notifier).loadMore();
          return true;
        }
        return false;
      },
    );
  }
}
