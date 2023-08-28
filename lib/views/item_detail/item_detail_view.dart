import 'package:flutter/material.dart';
import 'package:trade_app/component/item_detail_data_view.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/constant/item_detail_key.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/models/product_condition.dart';
import 'package:trade_app/views/item_detail/comments_view.dart';
import 'package:trade_app/views/item_detail/item_detail_common_view.dart';
import 'package:trade_app/views/item_detail/purchase_button_view.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView(this.item, {super.key});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final listingStatus = ListingStatus.values.byName(item.listingStatus);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    ItemDetailCommonView(item: item),
                    const CommentsView(),
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
            PurchaseButtonView(listingStatus: listingStatus),
          ],
        ),
      ),
    );
  }
}
