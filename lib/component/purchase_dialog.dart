import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';

class PurchaseDialog extends StatelessWidget {
  const PurchaseDialog({Key? key, required this.onTapUnpurchased,}) : super(key: key);
  final VoidCallback onTapUnpurchased;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      title: Text(
        Texts.alertMessage[0],
        style: const TextStyle(color: MyColors.primary),
      ),
      actions: [
        InkWell(
          onTap: () {
            onTapUnpurchased();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Texts.alertMessage[1],
              style: const TextStyle(color: MyColors.primary),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Texts.alertMessage[2],
              style: const TextStyle(color: MyColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
