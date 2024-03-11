import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {Key? key,
      required this.onPressed,
      this.buttonColor,
      this.textColor,
      required this.buttonText,
      this.height,
      this.width})
      : super(key: key);
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final String buttonText;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: buttonColor ?? MyColors.primary,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor ?? MyColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
