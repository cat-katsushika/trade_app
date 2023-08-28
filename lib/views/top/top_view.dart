import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/photo_model.dart';
import 'package:trade_app/views/item_detail/item_detail_view.dart';
import 'package:trade_app/views/top/item_list_view.dart';
import 'package:trade_app/views/top/item_list_view_model.dart';
import 'package:trade_app/views/top/items_query_provider.dart';

class TopView extends ConsumerStatefulWidget {
  const TopView({super.key});

  @override
  ConsumerState createState() => _TopViewState();
}

class _TopViewState extends ConsumerState<TopView> {
  final textEditingController=TextEditingController();
  bool isLoading =false;

  Future<void> _fetchItems(Map<String, dynamic> query) async {
    ref.read(itemsProvider.notifier).removeAll();
    ref.read(itemsQueryProvider.notifier).changeQuery(query);
    ref.read(itemsProvider.notifier).fetchItems(query);
    ref.read(itemsQueryProvider.notifier).incrementPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.ghostWhiteColor,
          // title: const Text(
          //     Texts.top,
          //   style: TextStyle(
          //     color: MyColors.primary,
          //   ),
          // ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: SizedBox(
              height: 46,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: TextFormField(
                  autocorrect: true,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: Texts.searchHintText,
                    prefixIcon: const Icon(Icons.search, size: 25, color: MyColors.secondary,),
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 12, 12, 10),
                    hintStyle: const TextStyle(color: MyColors.secondary),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: MyColors.secondary, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: MyColors.secondary, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: MyColors.tertiary, width: 1),
                    ),
                  ),
                  onFieldSubmitted: (value) async {
                    debugPrint('onFieldSubmitted: $value');
                    final query = {
                      "search":value,
                      "page":0,
                    };
                    _fetchItems(query);
                  },
                ),
              ),
            ),
          ),
        ),
        body: const ItemGridView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ItemDetailView(
                    Item(
                          id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                          imageSet: [
                            Photo(
                              id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                              photo: "https://picsum.photos/id/1/300",
                              uploadedAt: DateTime.now(),
                              parentItem: "3fa85f64-5717-4562-b3fc-2c963f66afa6"
                            )
                          ],
                          listingStatus: "unpurchased",
                          price: 0,
                          name: "string",
                          description: "string",
                          condition: "brandNew",
                          writingState: "none",
                          seller: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                          buyer: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                          receivableCampus: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                    )
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}