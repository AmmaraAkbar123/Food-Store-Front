import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class customArrowBackButton extends StatelessWidget {
  const customArrowBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.primary,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
