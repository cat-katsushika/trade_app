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
      {"search": "", "page": 0},
    );

    debugPrint(isLoading.toString());
    debugPrint("a");
    _scrollController.addListener(_loadMoreData);
  }

  _loadMoreData() async {
    if (isLoading) return;
    final query = ref.read(itemsQueryProvider);
    final pageNumber = query["page"];
    final itemCount = ref.read(itemsProvider).length;
    print(pageNumber);
    print(itemCount);
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent * 0.9) {
      isLoading = true;
      isError = false;
      try {
        debugPrint("c");
        ref.read(itemsQueryProvider.notifier).incrementPage();
        await ref.read(itemsProvider.notifier).fetchItems(query);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isError = true;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
        debugPrint("d");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsProvider);
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

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreData);
    _scrollController.dispose();
    super.dispose();
  }
}
