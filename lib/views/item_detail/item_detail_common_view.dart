import 'package:flutter/material.dart';
import 'package:trade_app/component/item_detail_data_view.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/product_condition.dart';
import 'package:trade_app/models/writing_state.dart';

class ItemDetailCommonView extends StatelessWidget {
  const ItemDetailCommonView({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  Widget build(BuildContext context) {
    final productCondition = ProductCondition.values.byName(item.condition);
    final writingState = WritingState.values.byName(item.writingState);
    final PageController controller = PageController();
    //出品者、状態、書き込みのデータをStringに変換
    final List<String> itemDetailData = [
      item.seller.split('@').first,
      productCondition.jpName,
      writingState.jpName
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: controller,
            itemCount: item.images.length,
            itemBuilder: (BuildContext context, int index) => Image.network(
              item.images[index].photoPath,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              },
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
                "¥${item.price}",
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
              //出品者、状態、書き込みというワードををTexts内のitemDetailKeyで定義
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var data in Texts.itemDetailKey) ...{
                          Text(
                            data,
                            style: MyTextStyles.mediumBold,
                          ),
                          const SizedBox(height: 8.0)
                        },
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var data in itemDetailData) ...{
                          Text(
                            data,
                            style: MyTextStyles.mediumNormal,
                          ),
                          const SizedBox(height: 8.0)
                        },
                      ],
                    ),
                  ),
                ],
              ),
              //キャンパスが複数ある場合に対応するため別対応
              Row(
                children: [
                  const ItemDetailDataView(
                      dataList: ['受取可能キャンパス'],
                      textStyle: MyTextStyles.mediumBold),
                  ItemDetailDataView(
                      dataList: [item.receivableCampus],
                      textStyle: MyTextStyles.mediumNormal),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
