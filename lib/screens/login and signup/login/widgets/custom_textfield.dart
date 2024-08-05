import 'package:flutter/material.dart';
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
    required this.controller, required this.border,  // Initialize the FocusNode property
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
        focusNode: focusNode, // Apply the FocusNode
        obscureText: obscureText,
        
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: MyColors.grey),
          filled: true,
          fillColor: MyColors.lightGrey, // Grey fill color
          border: border, // No border initially
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: MyColors.grey)
              : null, // Conditionally add the prefix icon
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey, // Use grey color for the suffix icon
                  ),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none, // No border when not focused
            borderRadius:
                BorderRadius.circular(10.0), // Consistent border radius
          ),
          focusedBorder: border
        ),
        style: TextStyle(color: MyColors.black),
      ),
    );
  }
}
