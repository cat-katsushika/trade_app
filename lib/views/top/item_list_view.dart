import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/top/item_card.dart';
import 'package:trade_app/views/top/item_list_view_model.dart';
import 'package:trade_app/views/top/items_query_provider.dart';

class ItemGridView extends ConsumerStatefulWidget {
  const ItemGridView({super.key});

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
    ref.read(itemsProvider.notifier).fetchItems(
      {"name": "", "page": 0},
    );

    debugPrint(isLoading.toString());
    _scrollController.addListener(_loadMoreData);
  }

  _loadMoreData() async {
    if (isLoading) return;
    final query = ref.read(itemsQueryProvider);
    final pageNumber = query["page"];
    print(pageNumber);
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent * 0.9) {
      isLoading = true;
      isError = false;
      try {
        ref.read(itemsQueryProvider.notifier).incrementPage();
        await ref.read(itemsProvider.notifier).fetchItems(query);
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
    return ref.watch(itemsProvider).when(
          data: (items) {
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  '検索結果は0件です。'
                ),
              );
            } else {
              return Stack(
                children: [
                  GridView.builder(
                    controller: _scrollController,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
