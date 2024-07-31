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
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.primary,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
