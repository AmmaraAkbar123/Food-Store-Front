import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool isPasswordField;
  final VoidCallback? onSuffixIconPressed;
  final double? width;
  final double? height;
  final IconData? prefixIcon; // New property for the prefix icon

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.isPasswordField = false,
    this.onSuffixIconPressed,
    this.width,
    this.height,
    this.prefixIcon, // Initialize the new property
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 46,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(width: 1.5, color: MyColors.grey),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: MyColors.grey)
              : null, // Conditionally add the prefix icon
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: onSuffixIconPressed,
                )
              : null,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
