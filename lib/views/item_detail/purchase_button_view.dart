import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    required this.onTapRepost,
    required this.onTapCancel,
    required this.onTapComplete,
    required this.onTapRelist,
  }) : super(key: key);
  final ListingStatus listingStatus;
  final VoidCallback onTapUnpurchased;
  final VoidCallback onTapRepost;
  final VoidCallback onTapCancel;
  final VoidCallback onTapComplete;
  final VoidCallback onTapRelist;
  final Item item;

  Widget _buttonView(ListingStatus listingStatus, BuildContext context,
      bool amISeller, bool amIBuyer) {
    if (amISeller) {
      if (listingStatus == ListingStatus.unpurchased) {
        return ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialogComponent(
                alertMessage: '出品を取りやめますか？',
                leftText: '取りやめる',
                rightText: Texts.buttonPopText,
                onTap: onTapCancel,
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.tertiary),
          ),
          child: const Text(
            "出品をやめる",
            style: TextStyle(color: MyColors.white),
          ),
        );
      } else if (listingStatus == ListingStatus.canceled) {
        return ElevatedButton(
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.tertiary),
          ),
          child: const Text(
            "再出品",
            style: TextStyle(color: MyColors.white),
          ),
        );
      } else {
        return const ElevatedButton(
          onPressed: null,
          child: Text("取引完了"),
        );
      }
    } else {
      if (listingStatus == ListingStatus.unpurchased) {
        return ElevatedButton(
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
          child: const Text("購入"),
        );
      } else if (listingStatus == ListingStatus.purchased && amIBuyer) {
        return ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return MessageView(
                item: item,
                onTapComplete: onTapComplete,
              );
            }));
          },
          child: const Text(
            "取引画面",
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return const ElevatedButton(
          onPressed: null,
          child: Text("SOLD OUT"),
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: 200,
          child: _buttonView(listingStatus, context, amISeller, amIBuyer),
        ),
      ),
    );
  }
}
