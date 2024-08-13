import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomArrowBackButton extends StatelessWidget {
  final VoidCallback? onPressed; // Add this parameter

  const CustomArrowBackButton({
    Key? key,
    this.onPressed, // Initialize the parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: MyColors.black,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.white,
              size: 12,
            ),
            onPressed: onPressed, // Use the callback
          ),
        ),
      ],
    );
  }
}
