import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiscountOffTagWidget extends StatelessWidget {
  const DiscountOffTagWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: MyColors.lightPrimary,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.discount_circle,
                color: MyColors.primary,
                size: 16,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Rs. 445 off",
                style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Min.order Rs. 445. Valid for selected items.\nAuto-applied",
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}

class AvailableDeals extends StatelessWidget {
  const AvailableDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
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
