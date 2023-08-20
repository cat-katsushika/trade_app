import 'package:flutter/material.dart';
import 'package:trade_app/component/item_detail_data_view.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/constant/item_detail_key.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/item_model.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView(this.item, {super.key});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final List<String> itemDetailData =  [item.sellerId, item.condition, item.receivableCampus];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: item.photo.length,
                        itemBuilder: (BuildContext context, int index) => Image.network(
                          item.photo[index].photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: MyColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "¥${item.price.toString()}",
                            style: const TextStyle(
                              color: MyColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            "商品の説明",
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                         Text(
                             item.description,
                            style: const TextStyle(
                              color: MyColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const ItemDetailDataView(dataList: ItemDetailKey.itemDetailKey, textStyle: MyTextStyles.mediumBold),
                              ItemDetailDataView(dataList: itemDetailData, textStyle: MyTextStyles.mediumNormal),
                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: MyColors.secondary,

                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (_) {
                        return const PurchaseDialog();
                      });
                    },
                    child: const Text(
                      "購入"
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
