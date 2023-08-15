import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/views/top/item_list_view_model.dart';

class ItemGridView extends ConsumerWidget {
  const ItemGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsyncValue = ref.watch(itemListProvider);

    return itemsAsyncValue.when(
      data: (items) => RefreshIndicator(
        onRefresh:()=> ref.refresh(itemListProvider.future),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Column(
              children: [
                Image.network(item.photo.first.photo),
                Text(item.name),
              ],
            );
          },
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) {
        debugPrint(err.toString());
        return Text('Error: $err');
      },
    );
  }
}
