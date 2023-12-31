import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/views/notification/notification_view.dart';
import 'package:trade_app/views/top/item_grid_view.dart';
import 'package:trade_app/views/top/item_grid_view_model.dart';

class TopView extends ConsumerStatefulWidget {
  const TopView({super.key, this.snackMessage});

  final String? snackMessage;

  @override
  ConsumerState createState() => _TopViewState();
}

class _TopViewState extends ConsumerState<TopView> {
  final textEditingController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    //画面描画後に処理をコールバックで実行するもの
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future(() {
        if (widget.snackMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.snackMessage!),
            ),
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isShowSoldItem =
        ref.watch(itemsProvider.notifier).getIsShowSoldItem();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationView(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_outlined),
                ),
                GestureDetector(
                  onTap: () async {
                    isShowSoldItem = !isShowSoldItem;
                    //サクサク動かしたいのでチェックボックスの表示を切り替えてからローディング
                    setState(() {});
                    ref
                        .read(itemsProvider.notifier)
                        .setIsShowSoldItem(isShowSoldItem);
                    await ref.read(itemsProvider.notifier).fetch();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '売切も表示',
                        ),
                        Icon(
                          isShowSoldItem
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          backgroundColor: MyColors.ghostWhiteColor,
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
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 25,
                      color: MyColors.secondary,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 12, 12, 10),
                    hintStyle: const TextStyle(color: MyColors.secondary),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: MyColors.secondary, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: MyColors.secondary, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: MyColors.tertiary, width: 1),
                    ),
                  ),
                  onFieldSubmitted: (value) async {
                    //検索時の処理
                    debugPrint('onFieldSubmitted: $value');
                    ref.read(itemsProvider.notifier).changeName(value);
                    ref.read(itemsProvider.notifier).fetch();
                  },
                ),
              ),
            ),
          ),
        ),
        body: ItemGridView(
          provider: itemsProvider,
        ),
      ),
    );
  }
}
