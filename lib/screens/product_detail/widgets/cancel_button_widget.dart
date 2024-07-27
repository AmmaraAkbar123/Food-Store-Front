import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomCancelButton extends StatelessWidget {
  final double size;
  final VoidCallback onPressed;

  const CustomCancelButton({
    Key? key,
    this.size = 40.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.close,
            color: MyColors.primary,
            size:
                size * 0.5, // Adjust the icon size relative to the button size
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
