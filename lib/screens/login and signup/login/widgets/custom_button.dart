import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.onPressed,
    required this.text,
    this.color = MyColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // Default width is 328 if not provided
      height: height ?? 50, // Default height is 56 if not provided
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          //side: const BorderSide(color: Colors.white),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: MyColors.grey, fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
    );
  }
}
