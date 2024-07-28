
import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/store/app_bar/widgets/discount_offtag_widgets.dart';
import 'package:foodstorefront/utils/colors.dart';

class AvailableDeals extends StatelessWidget {
  const AvailableDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.event_available,
                  color: MyColors.primary,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Available deals",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        DiscountOffTagWidget()
      ],
    );
  }
}
