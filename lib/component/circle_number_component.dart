import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';

class CircleNumberComponent extends StatelessWidget {
  const CircleNumberComponent(
      {super.key,
      required this.number,
      required this.text,
      required this.isBlack});

  final int number;
  final String text;
  final bool isBlack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: isBlack ? MyColors.black : Colors.transparent,
            shape: BoxShape.circle, // 丸い形を設定
            border: isBlack ? null : Border.all(
              color: MyColors.grey,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isBlack ? MyColors.white : MyColors.grey, // テキストを白に設定
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: MyTextStyles.mediumBold,
        ),
      ],
    );
  }
}
