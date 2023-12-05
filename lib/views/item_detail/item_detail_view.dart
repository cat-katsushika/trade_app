import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/models/user_data_model.dart';
import 'package:trade_app/repository/item_repository.dart';
import 'package:trade_app/views/navigation_root/navigation_root.dart';
import 'package:trade_app/views/item_detail/comments_view.dart';
import 'package:trade_app/views/item_detail/item_detail_common_view.dart';
import 'package:trade_app/views/item_detail/purchase_button_view.dart';

class ItemDetailView extends StatefulWidget {
  const ItemDetailView(this.item, this.userData, {super.key});

  final Item item;
  final UserData userData;

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  patchTemplate(BuildContext context, String endpoint, String name) async {
    try {
      await ItemRepository.patchItemData(widget.item.id, endpoint);
      Future(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationRoot(snackMessage: '$nameが完了しました！'),
          ),
          (_) => false,
        );
      });
    } catch (e) {
      Future(() => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$nameに失敗しました。"),
            ),
          ));
      Navigator.pop(context);
    }
  }

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
                    ItemDetailCommonView(
                        item: widget.item, userData: widget.userData),
                    CommentsView(
                      item: widget.item,
                    ),
                    const SizedBox(height: 32),
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
              item: widget.item,
              listingStatus: listingStatus,
              onTapUnpurchased: () {
                patchTemplate(context, 'purchase', '購入');
              },
              onTapRelist: () {
                patchTemplate(context, 'relisting', '再出品');
              },
              onTapCancel: () {
                patchTemplate(context, 'cancel', '出品取り消し');
              },
              onTapComplete: () {
                patchTemplate(context, 'complete', '取引');
              },
            ),
          ],
        ),
      ),
    );
  }
}
