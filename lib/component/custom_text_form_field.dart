import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final Function(bool) onToggleObscure;
  final String? Function(String?)? validator;
  final bool hasObscureIcon;
  final Iterable<String> autofillHints;
  final TextInputType keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.hasObscureIcon,
    required this.controller,
    required this.hintText,
    required this.isObscure,
    required this.onToggleObscure,
    this.validator,
    required this.autofillHints,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        errorStyle: const TextStyle(
          color: MyColors.validationRed, // Hardcoded error text color
          fontSize: 12, // Example size
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: MyColors.validationRed,
              width: 1), // Hardcoded error border color
        ),
        hintText: hintText,
        suffixIcon: hasObscureIcon
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => onToggleObscure(!isObscure),
              )
            : null,
      ),
      validator: validator,
      // Use the validator passed in
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      obscureText: isObscure,
    );
  }
}
