import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trade_app/component/item_detail_data_view.dart';
import 'package:trade_app/constant/image_path.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/models/product_condition.dart';
import 'package:trade_app/models/user_data_model.dart';
import 'package:trade_app/models/writing_state.dart';
import 'package:trade_app/views/message_view/message_view.dart';

class ItemDetailCommonView extends StatelessWidget {
  const ItemDetailCommonView(
      {Key? key, required this.item, required this.userData})
      : super(key: key);
  final Item item;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    //brand_newに対してbyNameが使えないため例外処理
    final isMyItem = (item.buyer == userData.id || item.seller == userData.id);
    var productCondition = ProductCondition.brandNew;
    if (item.condition != 'brand_new') {
      productCondition = ProductCondition.values.byName(item.condition);
    }
    final writingState = WritingState.values.byName(item.writingState);
    final listingStatus = ListingStatus.values.byName(item.listingStatus);
    final PageController controller = PageController();
    //出品者、状態、書き込みのデータをStringに変換
    final List<String> itemDetailData = [
      item.seller.split('@').first,
      productCondition.jpName,
      writingState.jpName
    ];
    final formatter = NumberFormat("#,###");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: item.images.isNotEmpty
                  ? PageView.builder(
                      controller: controller,
                      itemCount: item.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl: item.images[index].photoPath,
                          fit: BoxFit.contain,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const CupertinoActivityIndicator(),
                          errorWidget: (context, url, dynamic error) =>
                              const Icon(Icons.error),
                        );
                      })
                  : Center(
                      child: Image.asset(ImagePath.errorImage),
                    ),
            ),
            if ((!isMyItem && listingStatus == ListingStatus.purchased) ||
                listingStatus == ListingStatus.completed)
              IgnorePointer(child: Image.asset(ImagePath.soldOutImage)),
            if (isMyItem && listingStatus == ListingStatus.purchased)
              IgnorePointer(child: Image.asset(ImagePath.tradingImage)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  color: MyColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                "¥${formatter.format(item.price)}",
                style: const TextStyle(
                  color: MyColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "商品の説明",
                style: TextStyle(
                  color: MyColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                item.description,
                style: const TextStyle(
                  color: MyColors.black,
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
                      dataList: ['受け取り場所'], textStyle: MyTextStyles.mediumBold),
                  ItemDetailDataView(
                      dataList: [item.receivableCampus],
                      textStyle: MyTextStyles.mediumNormal),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageView(
                              isComment: true,
                              item: item,
                              onTapComplete: null,
                              isShowCompleteButton: false,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: MyColors.primary,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'コメントする',
                            style: TextStyle(
                              color: MyColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
