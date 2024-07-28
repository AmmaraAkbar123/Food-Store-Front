import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "0.8km away | Rs. 79.00 delivery",
              style: TextStyle(color: MyColors.greyText, fontSize: 12),
            ),
            Text(
              "More info",
              style: TextStyle(
                  fontSize: 12,
                  color: MyColors.primary,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        Text(
          "Rs.249.00 minimum | Rs. 9.99 service",
          style: TextStyle(color: MyColors.greyText, fontSize: 12),
        ),
      ],
    );
  }
}
