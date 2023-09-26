import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/models/listing_status.dart';

class PurchaseButtonView extends ConsumerWidget {
  const PurchaseButtonView(
      {Key? key, required this.listingStatus, required this.onTapUnpurchased})
      : super(key: key);
  final ListingStatus listingStatus;
  final VoidCallback onTapUnpurchased;

  Widget _buttonView(ListingStatus listingStatus, BuildContext context) {
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
    } else if (listingStatus == ListingStatus.purchased) {
      return const ElevatedButton(
        onPressed: null,
        child: Text(
          "SOLD OUT",
          textAlign: TextAlign.center,
        ),
      );
    } else if (listingStatus == ListingStatus.canceled) {
      return const ElevatedButton(
        onPressed: null,
        child: Text("キャンセル済み"),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: 200,
          child: _buttonView(listingStatus, context),
        ),
      ),
    );
  }
}
