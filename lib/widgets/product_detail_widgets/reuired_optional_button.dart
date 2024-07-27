import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class RequiredOptionalButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color txtColor;
  const RequiredOptionalButton({
    super.key,
    required this.text,
    required this.color,
    this.txtColor = MyColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: txtColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
