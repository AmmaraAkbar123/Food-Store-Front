import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'package:foodstorefront/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final bool isPasswordField;
  final VoidCallback? onSuffixIconPressed;
  final double? width;
  final double? height;
  final IconData? prefixIcon; // Property for the prefix icon
  final FocusNode? focusNode; // FocusNode property
  final TextEditingController controller;
  final OutlineInputBorder border;
  final int maxLength; // Property for max input length
  final TextInputType keyboardType; // Property for keyboard type

  const CustomTextField({
    super.key,
    this.hintText,
    this.obscureText = false,
    this.isPasswordField = false,
    this.onSuffixIconPressed,
    this.width,
    this.height,
    this.prefixIcon,
    this.focusNode,
    required this.controller,
    required this.border,
    required this.maxLength, // Initialize maxLength
    this.keyboardType = TextInputType.text, // Initialize keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: maxLength != null
            ? [
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
                LengthLimitingTextInputFormatter(maxLength), // Limit to maxLength
              ]
            : null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: MyColors.black87),
          border: border,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: MyColors.GreyWithDarkOpacity)
              : null,
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.GreyWithDarkOpacity),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: border,
        ),
        style: TextStyle(color: MyColors.black),
      ),
    );
  }
}
