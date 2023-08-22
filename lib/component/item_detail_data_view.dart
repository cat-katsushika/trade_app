import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';

class ItemDetailDataView extends StatelessWidget {
  const ItemDetailDataView({Key? key, required this.dataList, required this.textStyle}) : super(key: key);
  final List<String> dataList;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var data in dataList)...{
            Text(
              data,
              style: textStyle,
            ),
            const SizedBox(height: 8.0)
          }
        ],
      ),
    );
  }
}
