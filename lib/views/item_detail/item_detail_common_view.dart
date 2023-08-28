import 'package:flutter/material.dart';
import 'package:trade_app/component/item_detail_data_view.dart';
import 'package:trade_app/constant/item_detail_key.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/models/product_condition.dart';
import 'package:trade_app/models/writing_state.dart';
import 'package:trade_app/views/item_detail/comments_view.dart';

class ItemDetailCommonView extends StatelessWidget {
  const ItemDetailCommonView({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    final productCondition = ProductCondition.values.byName(item.condition);
    final listingStatus = ListingStatus.values.byName(item.listingStatus);
    final writingState = WritingState.values.byName(item.writingState);
    final PageController controller = PageController();
    final List<String> itemDetailData =  [item.seller, productCondition.jpName, writingState.jpName, item.receivableCampus];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // SizedBox(height: 30),
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: controller,
            itemCount: item.imageSet.length,
            itemBuilder: (BuildContext context, int index) => Image.network(
              item.imageSet[index].photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        ),
      ],
    );
  }
}
