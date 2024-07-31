import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomSocialButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.53),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(width: 1, color: MyColors.lightGrey),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 24, height: 24),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
