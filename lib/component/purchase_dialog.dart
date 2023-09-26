import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';

class AlertDialogComponent extends StatelessWidget {
  const AlertDialogComponent({
    Key? key,
    required this.onTap,
    required this.alertMessage,
    required this.leftText,
    required this.rightText,
  }) : super(key: key);
  final VoidCallback onTap;
  final String alertMessage;
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      title: Text(
        alertMessage,
        style: const TextStyle(color: MyColors.primary),
      ),
      actions: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              leftText,
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
              rightText,
              style: const TextStyle(color: MyColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
