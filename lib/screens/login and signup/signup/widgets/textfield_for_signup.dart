import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/utils/colors.dart';

class SignUpTextfield extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData? prefixIcon;
  final String hintText;
  final InputBorder border;
  final Color? fillColor;
  final Color? iconColor;
  //final int? maxLength; // Property for max input length
  final TextInputType keyboardType; // Property for keyboard type

  const SignUpTextfield({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.prefixIcon,
    required this.hintText,
    required this.border,
    this.fillColor,
    this.iconColor,
    //  this.maxLength, // Initialize maxLength
    this.keyboardType = TextInputType.text, // Initialize keyboardType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      // inputFormatters: maxLength != null
      //     ? [
      //         FilteringTextInputFormatter.digitsOnly, // Allow only digits
      //         LengthLimitingTextInputFormatter(maxLength), // Limit to maxLength
      //       ]
      //     : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.GreyWithOp,
        prefixIcon: Icon(prefixIcon, color: iconColor),
        hintText: hintText,
        hintStyle: TextStyle(color: MyColors.GreyWithDarkOpacity, fontSize: 13),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15,
        ), // Adjusted padding
      ),
      textAlign: TextAlign.left, // Align text to the left
    );
  }
}
