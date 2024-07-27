import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
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
              Icons.lock_clock_outlined,
              color: MyColors.primary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Delivery: 10-25 min",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Text(
          "Change",
          style: TextStyle(
              fontSize: 12, color: MyColors.grey, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
