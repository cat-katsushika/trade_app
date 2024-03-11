import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/button_component.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/views/message_view/message_view.dart';

class PurchaseButtonView extends ConsumerWidget {
  const PurchaseButtonView({
    Key? key,
    required this.item,
    required this.listingStatus,
    required this.onTapUnpurchased,
    required this.onTapCancel,
    required this.onTapComplete,
    required this.onTapRelist,
  }) : super(key: key);
  final ListingStatus listingStatus;
  final VoidCallback onTapUnpurchased;
  final VoidCallback onTapCancel;
  final VoidCallback onTapComplete;
  final VoidCallback onTapRelist;
  final Item item;

  Widget _buttonView(ListingStatus listingStatus, BuildContext context,
      bool amISeller, bool amIBuyer) {
    if (amISeller) {
      if (listingStatus == ListingStatus.unpurchased) {
        return ButtonComponent(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialogComponent(
                alertMessage: '出品を取り消しますか？',
                leftText: '取り消す',
                rightText: Texts.buttonPopText,
                onTap: onTapCancel,
              ),
            );
          },
          buttonText: "出品を取り消す",
          buttonColor: MyColors.tertiary,
        );
      } else if (listingStatus == ListingStatus.purchased) {
        return ButtonComponent(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return MessageView(
                isComment: false,
                item: item,
                onTapComplete: onTapComplete,
                isShowCompleteButton: amISeller,
              );
            }));
          },
          buttonText: "取引画面",
          buttonColor: MyColors.secondary,
        );
      } else if (listingStatus == ListingStatus.canceled) {
        return ButtonComponent(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialogComponent(
                alertMessage: '再出品しますか？',
                leftText: '再出品する',
                rightText: Texts.buttonPopText,
                onTap: onTapRelist,
              ),
            );
          },
          buttonText: "再出品",
          buttonColor: MyColors.tertiary,
        );
      } else {
        return const ButtonComponent(
          onPressed: null,
          buttonText: "取引完了",
          buttonColor: MyColors.grey,
        );
      }
    } else {
      if (listingStatus == ListingStatus.unpurchased) {
        return ButtonComponent(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialogComponent(
                alertMessage: '購入しますか？',
                leftText: '購入',
                rightText: Texts.buttonPopText,
                onTap: onTapUnpurchased,
              ),
            );
          },
          buttonText: "購入",
        );
      } else if (listingStatus == ListingStatus.purchased && amIBuyer) {
        return ButtonComponent(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return MessageView(
                isComment: false,
                item: item,
                onTapComplete: onTapComplete,
                isShowCompleteButton: amISeller, //自分が出品者の場合のみ取引完了ボタンを表示
              );
            }));
          },
          buttonText: "取引画面",
          buttonColor: MyColors.secondary,
        );
      } else {
        return const ButtonComponent(
          onPressed: null,
          buttonText: "SOLD OUT",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('seller:${item.seller}');
    debugPrint('buyer:${item.buyer}');
    debugPrint('email:${ref.read(userDataProvider).id}');

    final amISeller = (item.seller == ref.read(userDataProvider).email);
    final amIBuyer = (item.buyer == ref.read(userDataProvider).id);
    //↑なぜかsellerはuserのemail, buyerはuserのidが返ってきているのでこの実装。
    return _buttonView(listingStatus, context, amISeller, amIBuyer);
  }
}
