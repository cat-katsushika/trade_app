import 'package:flutter/material.dart';
import 'package:trade_app/models/listing_status.dart';

class PurchaseButtonView extends StatelessWidget {
  const PurchaseButtonView({Key? key, required this.listingStatus})
      : super(key: key);
  final ListingStatus listingStatus;

  Widget _buttonView(ListingStatus listingStatus) {
    if (listingStatus == ListingStatus.unpurchased) {
      return ElevatedButton(
        onPressed: () {},
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
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: 200,
          child: _buttonView(listingStatus),
        ),
      ),
    );
  }
}
