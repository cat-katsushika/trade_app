import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/views/item_detail/comments_view.dart';
import 'package:trade_app/views/item_detail/item_detail_common_view.dart';
import 'package:trade_app/views/item_detail/purchase_button_view.dart';

class ItemDetailView extends StatefulWidget {
  const ItemDetailView(this.item, {super.key});

  final Item item;

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  final newCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listingStatus =
        ListingStatus.values.byName(widget.item.listingStatus);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    ItemDetailCommonView(item: widget.item),
                    CommentsView(newCommentController: newCommentController),
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
            PurchaseButtonView(
              listingStatus: listingStatus,
              onTapUnpurchased: (value) {

              },
            ),
          ],
        ),
      ),
    );
  }
}
