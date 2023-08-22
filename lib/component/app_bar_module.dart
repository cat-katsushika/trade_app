import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/styles.dart';

class AppBarModule extends StatelessWidget implements PreferredSizeWidget {
  const AppBarModule({
    Key? key,
    required this.title,
    this.leading,
  }) : super(key: key);
  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: Styles.boxShadow2),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
        child: AppBar(
          backgroundColor: MyColors.secondary,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(
              color: MyColors.primary,
            ),
          ),
          leadingWidth: 68,
          leading: leading,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
