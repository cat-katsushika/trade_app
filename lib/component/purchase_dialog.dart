import 'package:flutter/material.dart';
import 'package:trade_app/constant/texts.dart';

class PurchaseDialog extends StatelessWidget {
  const PurchaseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        Texts.alertMessage[0],
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Texts.alertMessage[1],
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
            ),
          ),
        ),
      ],
    );
  }
}
