import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';

class SettingsItemComponent extends StatelessWidget {
  const SettingsItemComponent({
    Key? key,
    this.logOut = false,
    this.onTap,
    required this.title,
    required this.trailing,
  }) : super(key: key);

  final bool logOut;
  final VoidCallback? onTap;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        EdgeInsets.symmetric(vertical: logOut ? 8 : 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: MyColors.primary, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
            ),
            trailing
          ],
        ),
      ),
    );
  }
}
