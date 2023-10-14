import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';

class PurchaseButtonView extends ConsumerWidget {
  const PurchaseButtonView(
      {Key? key,
      required this.item,
      required this.listingStatus,
      required this.onTapUnpurchased})
      : super(key: key);
  final ListingStatus listingStatus;
  final VoidCallback onTapUnpurchased;
  final Item item;

  Widget _buttonView(ListingStatus listingStatus, BuildContext context,
      bool isMeSeller, bool isMeBuyer) {
    print(isMeSeller);
    print(isMeBuyer);
    print(listingStatus);
    if (isMeSeller) {
      if (listingStatus == ListingStatus.unpurchased) {
        return ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialogComponent(
                  alertMessage: '削除しますか？',
                  leftText: '削除',
                  rightText: 'キャンセル',
                  onTap: () {
                    //TODO:delete item
                  }),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.tertiary),
          ),
          child: const Text("削除",style: TextStyle(color: MyColors.white),),
        );
      } else if (listingStatus == ListingStatus.canceled) {
        return ElevatedButton(
          onPressed: () {
            //TODO: patch再出品
          },
          child: const Text("再出品"),
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
                rightText: 'キャンセル',
                onTap: onTapUnpurchased,
              ),
            );
          },
          child: const Text("購入"),
        );
      } else if (listingStatus == ListingStatus.purchased && isMeBuyer) {
        return ElevatedButton(
          onPressed: () {
            //TODO:取引画面へ遷移
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
    final isMeSeller = (item.seller == ref.read(userDataProvider).email);
    final isMeBuyer = (item.buyer == ref.read(userDataProvider).id);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: 200,
          child: _buttonView(listingStatus, context, isMeSeller, isMeBuyer),
        ),
      ),
    );
  }
}
