import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity, // Default width is 328 if not provided
      height: height ?? 50, // Default height is 56 if not provided
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          //side: const BorderSide(color: Colors.white),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: MyColors.white, fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
    );
  }
}
