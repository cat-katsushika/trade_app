import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 2,
      color: MyColors.vividBlack,
    );
  }
}
