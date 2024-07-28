import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class SeeReviews extends StatelessWidget {
  const SeeReviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.star_border_outlined,
              color: MyColors.primary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "4.7",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "10000+ ratings",
              style: TextStyle(color: MyColors.greyText, fontSize: 12),
            )
          ],
        ),
        Text(
          "See Reviews",
          style: TextStyle(
              fontSize: 12,
              color: MyColors.primary,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
