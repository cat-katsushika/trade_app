import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/top/item_card.dart';
import 'package:trade_app/views/top/item_list_view_model.dart';
import 'package:trade_app/views/top/items_query_provider.dart';

class ItemGridView extends ConsumerStatefulWidget {
  const ItemGridView({
    required this.url,
    required this.provider,
    required this.queryProvider,
    super.key,
  });

  final String url;
  final StateNotifierProvider<ItemsNotifier, AsyncValue<List<Item>>> provider;
  final StateNotifierProvider<ItemsQueryNotifier, Map<String, dynamic>>
      queryProvider;

  @override
  ConsumerState createState() => _ItemGridViewState();
}

class _ItemGridViewState extends ConsumerState<ItemGridView> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    Future(() => {
          ref.read(widget.provider.notifier).removeAll(),
          ref.read(widget.provider.notifier).fetchItems(
            {
              "name": "",
              "page": 0,
              "listing_status": "unpurchased",
            },
            widget.url,
          ),
          ref.read(widget.queryProvider.notifier).incrementPage(),
        });

    debugPrint(isLoading.toString());
    _scrollController.addListener(_loadMoreData);
  }

  _loadMoreData() async {
    if (isLoading) return;
    final query = ref.read(widget.queryProvider);
    final pageNumber = query["page"];
    print(pageNumber);
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent * 0.9) {
      isLoading = true;
      isError = false;
      try {
        ref.read(widget.queryProvider.notifier).incrementPage();
        await ref.read(widget.provider.notifier).fetchItems(query, widget.url);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isError = true;
          // throw Exception();
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(widget.provider).when(
          data: (items) {
            if (items.isEmpty) {
              return const Center(
                child: Text('検索結果は0件です。'),
              );
            } else {
              return Stack(
                children: [
                  GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return ItemCard(item: items[index]);
                    },
                    itemCount: items.length,
                  ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primary,
                      ),
                    ),
                  if (isError) const Center(child: Text('エラーが発生しました。')),
                ],
              );
            }
          },
          error: (error, stacktrace) {
            debugPrint(error.toString());
            return const Center(
              child: Text(
                'エラーが発生しました',
                textAlign: TextAlign.center,
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreData);
    _scrollController.dispose();
    super.dispose();
  }
}
